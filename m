Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1fL30C-0002nO-9c
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1fL309-0003je-ON
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:50:40 -0400
Received: from mail.univention.de ([82.198.197.8]:24870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1fL309-0003jH-H0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by solig.knut.univention.de (Postfix) with ESMTP id E289F1F19F76
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:50:34 +0200 (CEST)
Received: from mail.univention.de ([127.0.0.1])
	by localhost (solig.knut.univention.de [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 99kGqK7AJibk for <qemu-devel@nongnu.org>;
	Tue, 22 May 2018 10:50:30 +0200 (CEST)
Received: from [192.168.0.82] (mail.univention.de [82.198.197.8])
	by solig.knut.univention.de (Postfix) with ESMTPSA id 8793F1F19F63
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:50:30 +0200 (CEST)
References: <20180518180440-mutt-send-email-mst@kernel.org>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <3b5cc5b2-a25c-bf84-0501-0d3a00b867c2@univention.de>
Date: Tue, 22 May 2018 10:50:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180518180440-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Am 18.05.2018 um 17:30 schrieb Michael S. Tsirkin:
> Unfortunately this means that it's no longer possible
> to more or less reliably boot a VM just given a disk image,
> even if you select the correct QEMU binary:
...
> Would it be reasonable to support storing this information in the qcow
> image itself?  For example, I can see it following immediately the
> backing file path within the image.

- This looks like a layering violation
- what happens when you have multiple (conflicting) images like a VM
with 2 image files?

Philipp

PS: this is even more an issue for restoring snapshots as you the must
launch a new QEMU process with the exact layout of the saving QEMU
process - otherwise LoadVM will just fail.
PPS: I'm afraid of someone suggesting such an abomination as those self
extracting archives using shell scripts at the beginning and an
compressed archive BLOB at the end of the same file.
