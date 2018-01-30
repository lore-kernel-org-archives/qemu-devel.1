Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egWf1-0007XO-Cw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egWex-000790-Bh
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:13:19 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egWex-000789-5P
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:13:15 -0500
Received: by mail-wr0-f193.google.com with SMTP id w50so11338066wrc.2
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 06:13:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b0a1f5dd-dc2a-cb80-b1d2-f94215594cbb@redhat.com>
References: <20180130062503.32596-1-famz@redhat.com>
	<b0a1f5dd-dc2a-cb80-b1d2-f94215594cbb@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 30 Jan 2018 22:12:43 +0800
Message-ID: <CAK1Eb9k9_Zs=hoRHXyEQ755xb9PZWq+xmhK=-Y2AUEcGTVT=XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Jan 30, 2018 at 9:48 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/30/2018 12:25 AM, Fam Zheng wrote:
>> This reverts commit 76bf133c4 which updated the reference output, and
>> fixed the reference image, because the code path we want to exercise is
>> actually the invalid image size.
>>
>> The descriptor block in the image, which includes the CID to verify, has been
>> invalid since the reference image was added. Since commit 9877860e7bd we report
>> this error earlier than the "file too large", so 059.out mismatches.
>>
>> The binary change is generated along the operations of:
>>
>>   $ bunzip2 afl9.vmdk.bz2
>>   $ qemu-img create -f vmdk fix.vmdk 1G
>>   $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
>
> Is the .bz2 suffix spurious here?

Hmm, yes. I have no idea why it is here. :-/

Fam

>
>>   $ mv fix.vmdk afl9.vmdk
>>   $ bzip2 afl9.vmdk
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> ---
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
