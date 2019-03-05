Received: from eggs.gnu.org ([209.51.188.92]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Fre-0000eG-Kz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1FrX-00021f-1G
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:36:30 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:19851 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1FrR-0001q5-1p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:36:22 -0500
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
	by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 945F176A1
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:36:18 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7026A5A04F
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:36:18 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D7F5A05E
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:36:18 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
	by imsva2.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:36:18 +0100 (CET)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
	[209.85.166.42]) by smtp2 (Postfix) with ESMTPSA id 096A7676F
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:36:18 +0100 (CET)
Received: by mail-io1-f42.google.com with SMTP id x4so8074856ion.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 11:36:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
	<3249d2a0-f981-9da1-c4a0-f61dc0acd66d@redhat.com>
In-Reply-To: <3249d2a0-f981-9da1-c4a0-f61dc0acd66d@redhat.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 20:36:07 +0100
Message-ID: <CAGZZdDH1CvhvJ7ZoCGgc8wYgk01ePn_7VnWdacaEkRVNSMTxvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
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
> You are correct that 'printf -1' is likely to fail, 'printf -- -1' is
> portable but unusual, and 'printf %s\\n -1' is identical to the common
> (but non-portable) behavior of 'echo -1'. Is the newline important?

In this case, the newline seems not to be relevant. I find 'printf --
-1' elegant, but since I already submitted v2 of the patch, I think
the difference compared to 'printf %s -1' is not worth a new version.
Please, let me know if you feel otherwise.
