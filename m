Received: from eggs.gnu.org ([2001:4830:134:3::10]:37399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cjOs7-0000ak-Jh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cjOs3-0002gA-0K
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:26:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cjOs2-0002ef-NC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:26:06 -0500
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
	<20170301171735.GE1760@perard.uk.xensource.com>
	<61002dc9691a49d98a7feca8c9a676ce@AMSPEX02CL03.citrite.net>
	<20170302105438.GG1760@perard.uk.xensource.com>
	<28a1567a-ef14-e7e6-0de7-b8de0fae7618@suse.com>
	<41a5070ecb3446658c55f807c37eb5ea@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <96cdf110-8fe4-1e47-c1cf-bbb7ca0760f0@suse.com>
Date: Thu, 2 Mar 2017 12:26:03 +0100
MIME-Version: 1.0
In-Reply-To: <41a5070ecb3446658c55f807c37eb5ea@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 4/5] configure: detect presence
 of libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 02/03/17 12:06, Paul Durrant wrote:
>> -----Original Message-----
>> From: Juergen Gross [mailto:jgross@suse.com]
>> Sent: 02 March 2017 11:01
>> To: Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
>> <Paul.Durrant@citrix.com>
>> Cc: xen-devel@lists.xenproject.org; Stefano Stabellini
>> <sstabellini@kernel.org>; qemu-devel@nongnu.org
>> Subject: Re: [Xen-devel] [PATCH 4/5] configure: detect presence of
>> libxendevicemodel
>>
>> On 02/03/17 11:54, Anthony PERARD wrote:
>>> On Thu, Mar 02, 2017 at 09:06:43AM +0000, Paul Durrant wrote:
>>>>> -----Original Message-----
>>>>> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
>>>>> Sent: 01 March 2017 17:18
>>>>> To: Paul Durrant <Paul.Durrant@citrix.com>
>>>>> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
>>>>> Stabellini <sstabellini@kernel.org>
>>>>> Subject: Re: [PATCH 4/5] configure: detect presence of
>> libxendevicemodel
>>>>>
>>>>> On Thu, Feb 23, 2017 at 02:53:54PM +0000, Paul Durrant wrote:
>>>>>> This patch adds code in configure to set
>>>>> CONFIG_XEN_CTRL_INTERFACE_VERSION
>>>>>> to a new value of 490 if libxendevicemodel is present in the build
>>>>>> environment.
>>>>>>
>>>>>> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>>>>>> ---
>>>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>>>> ---
>>>>>>  configure | 19 +++++++++++++++++++
>>>>>>  1 file changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/configure b/configure
>>>>>> index 8e8f18d..fc1e12b 100755
>>>>>> --- a/configure
>>>>>> +++ b/configure
>>>>>> @@ -1980,6 +1980,25 @@ EOF
>>>>>>    # Xen unstable
>>>>>>    elif
>>>>>>        cat > $TMPC <<EOF &&
>>>>>> +#undef XC_WANT_COMPAT_DEVICEMODEL_API
>>>>>> +#define __XEN_TOOLS__
>>>>>
>>>>> Isn't __XEN_TOOLS__ supposed to be reserved for some to tools inside
>>>>> xen.git?
>>>>>
>>>>> Also it seems to be the only time this define is used in your patch
>>>>> series.
>>>>>
>>>> No. QEMU falls under the definition of 'tools' as far as Xen goes and the
>> hypercalls and xendevicemodel API are protected by that. The reason you
>> don't see it elsewhere is that xenctrl.h defines it. (See
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=tools/libxc/include/xenc
>> trl.h;hb=HEAD#l27).
>>>> I think that's a little underhand so I thought I'd make the new code in
>> configure more transparent. I can change it to just include xenctrl.h before
>> xendevicemodel.h if you'd prefer.
>>>
>>> I guess that is fine with __XEN_TOOLS__.
>>> You can add my
>>> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>>>
>>
>> Sorry for jumping in only now:
>>
>> Wouldn't it be better to base qemu's configure modification for support
>> of Xen 4.9 (and newer) on my just posted series introducing pkg-config?
>>
>> I'm just about to expand this series to all of Xen's libraries and I
>> already have a qemu patch at hand supporting this new scheme.
> 
> Ok, but I'm at v2 and I was literally just about to post. I guess it will also be pretty trivial to change configure after this change has been applied.

Sure, this will work.

Its your decision. :-)


Juergen
