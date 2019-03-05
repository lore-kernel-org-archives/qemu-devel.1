Received: from eggs.gnu.org ([209.51.188.92]:52746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Gfr-0008KJ-UI
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Gfq-0007iG-VE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:28:27 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:27356 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1Gfq-0007eJ-6D
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:28:26 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 48DC92F897
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 21:28:22 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB5E110050
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 21:28:22 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04B63110045
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 21:28:22 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 21:28:21 +0100 (CET)
Received: from mail-it1-f170.google.com (mail-it1-f170.google.com
	[209.85.166.170]) by smtp1 (Postfix) with ESMTPSA id A96592F897
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 21:28:21 +0100 (CET)
Received: by mail-it1-f170.google.com with SMTP id l15so6586187iti.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 12:28:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
	<CAGZZdDHJ2+TFZ1ZvVtR-xfUOJj=gxEKvwHXH0Trn6ra=2Xd9og@mail.gmail.com>
	<7c650cfd-9e23-6822-e999-2bc828b7d0f1@redhat.com>
In-Reply-To: <7c650cfd-9e23-6822-e999-2bc828b7d0f1@redhat.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 21:28:10 +0100
Message-ID: <CAGZZdDGb0KVCnmkrGnebMYJy+F_4h72WBN23DJae6YnRQcnZDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-binfmt-conf.sh: add CPUS,
 add --reset, make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Unai_Mart=C3=ADnez_Corral?= <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

2019/3/5 17:57, Eric Blake:
> I don't have a strong preference between the two forms - so this is your
> chance to assert your creative liberty. But I don't know enough about
> binfmt_misc to know if the newline matters. I'm just reviewing on the
> basis of shell portability, and hope that other reviewers more familiar
> with binfmt will review on content.

According to https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst
it seems that only the integer matters. However, I'd also like to hear
any other thoughts.

> you may want to split this into a series of
> patches for v3, although you could also wait a day or so to see if
> anyone else reviews and minimize the list churn.

I will do so. It will take some time to reorganize the content and
apply the latest fixes.

> Welcome to the qemu community, and I hope you find your experience with
> your first patch pleasant.

Thanks! I'm really struggling to find a proper mail client, since I'm
on Windows and none of the web clients work properly for me.
But I hope I'll find some workaround.

> Long subject line, I'd trim ' (no arg)'. The commit body itself should
> go into the "why" the patch is useful (what behaviors are you fixing,
> what risk of backwards-compatibility breaks do we have to contend with
> for older clients of the script, etc).

Will do.

>  Also, a v2 patch is best sent as
> a new top-level thread, rather than in-reply to the v1 (as some of our
> automated CI tooling misses it otherwise).

I'm sorry I missed this explanation.

Thanks again for your time and suggestions.

Unai
