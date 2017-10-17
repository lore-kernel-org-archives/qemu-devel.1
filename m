Received: from eggs.gnu.org ([2001:4830:134:3::10]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e4VBw-00039e-Na
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e4VBt-0001XJ-F8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gmoro@suse.de>) id 1e4VBt-0001WW-82
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:58:05 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1F535ABF4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 16:58:03 +0000 (UTC)
References: <58f74661-3830-4127-e30b-37baebeba532@suse.de>
	<20171014094543.GA32099@lemon>
From: Guilherme Moro <gmoro@suse.de>
Message-ID: <de756175-739a-2df5-3ce5-11409a8977b8@suse.de>
Date: Tue, 17 Oct 2017 17:58:01 +0100
MIME-Version: 1.0
In-Reply-To: <20171014094543.GA32099@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-img convert to VMDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 10/14/2017 10:45 AM, Fam Zheng wrote:
> On Fri, 10/13 15:20, Guilherme Moro wrote:
>> Hi,
>>
>> I'm trying to convert some images from raw to vmdk to run in a ESXi6.5
>> server but I need to rectify the image before being able to run.
>>
>> The scenario goes like that:
>>
>> qemu-img convert -f raw image.raw -O vmdk -o compat6 image.vmdk
>> ESXi complains with "Failed - File system specific implementation of
>> LookupAndOpen"[file] failed
>> running vmkfstools -x repair on the image make it bootable
>>
>>  =C2=A0I checked the changes, vmkfstools is basically removing the sec=
ond
>> descriptor from the end of the file, I'm not familiar enough with the =
code
>> and the format to know what this means, maybe compat6 should make qemu=
-img
>> avoid to put that in the end of the file (again, mostly guessing).
>>
>> Anyway we would need an option to make sure that this second descripto=
r does
>> not end in the final image.
> What do you mean by "second descriptor"? The one at offset 0x200? But o=
ther than
> this descriptor I don't see a second one. Maybe I'm missing something?
>
> Fam
>
Hi,

never mind that, another tool was touching the description and writing=20
it in the wrong place, sorry the false alarm :)
