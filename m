Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1ecAIt-0004LO-IF
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1ecAIp-0005B3-HU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:32:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1ecAIp-0005Ak-BV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:32:23 -0500
Received: from mail-yw0-f198.google.com ([209.85.161.198])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1ecAIn-000649-PL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:21 +0000
Received: by mail-yw0-f198.google.com with SMTP id n70so15647787ywd.20
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:32:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118141530.17faabd1.cohuck@redhat.com>
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118125322.252929dc.cohuck@redhat.com>
	<06e97f00-710a-c893-101f-0a1c6aaa5575@de.ibm.com>
	<20180118141530.17faabd1.cohuck@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 18 Jan 2018 14:31:50 +0100
Message-ID: <CAATJJ0+4djFATj5qYn5UR=OtK4w0qT2PcPySeMXXNT7PSaQhPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] s390x/kvm: implement new
 hardware/firmware features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 18, 2018 at 2:15 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Thu, 18 Jan 2018 13:47:54 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> Have the x86 features been marked as stable? If the answer is yes,
>> shall we mark these patches for stable as well?
>
> Doesn't look like it.
>
> TBH, I'm not quite sure whether this should go into stable as I'm a bit
> unclear what our use case for stable is. It seems to be mostly "don't
> let people run into known crashes" or something like that.

I read the public statement [1] as "... non-x86 processors ...
backported to recent stable releases." or did the changes in
discussion here end up structurally so different that this doesn't
apply anymore?

[1]: https://www.qemu.org/2018/01/04/spectre/
