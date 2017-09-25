Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dwV87-0008F9-RA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dwV82-0000iM-71
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46004 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dwV82-0000dF-1R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:17:02 -0400
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
	<a5d319a8-627b-a0c5-8642-8c6d5f400213@suse.com>
	<20170925150858.GB25986@perard.uk.xensource.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <9f3ee3f8-2ff3-941c-0ab7-74da50a4a59c@suse.com>
Date: Mon, 25 Sep 2017 17:16:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170925150858.GB25986@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On 25/09/17 17:08, Anthony PERARD wrote:
> On Fri, Sep 22, 2017 at 02:14:16PM +0200, Juergen Gross wrote:
>> On 15/09/17 20:09, Ian Jackson wrote:
>>> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
>>> ---
>>>  configure | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index fd7e3a5..c59a0c0 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2072,14 +2072,14 @@ if test "$xen" != "no" ; then
>>>        $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>>>      xen=yes
>>>      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
>>> -    xen_pc="$xen_pc xenevtchn xendevicemodel"
>>> +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
>>>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>>>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
>>>      LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
>>>    else
>>>  
>>>      xen_libs="-lxenstore -lxenctrl -lxenguest"
>>> -    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
>>> +    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn -lxentoolcore"
>>
>> I don't think this is necessary. libxentoolcore is only available with
>> a new Xen, which will always have the xentoolcore.pc file installed.
> 
> Only if ! echo $EXTRA_LDFLAGS | grep tools/libxc;
> 
> So building qemu via xen.git Makefiles, the pkg-config files are not
> taken into account.
> 

Aah, right, this patch for the Xen build system is still missing.

In Xen 4.11 we should drop passing all the flags to configure and use
the pkg-config files instead.


Juergen
