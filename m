Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZyt2-0008JZ-Ef
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZysy-0001NF-HB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:29:00 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:45615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZysy-0001Mq-8k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:28:56 -0400
Received: by mail-wr0-x231.google.com with SMTP id u7-v6so15561597wrn.12
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:28:56 -0700 (PDT)
References: <20180629205232.27190-1-alex.bennee@linaro.org>
	<20180629205232.27190-17-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180629205232.27190-17-alex.bennee@linaro.org>
Date: Mon, 02 Jul 2018 14:28:53 +0100
Message-ID: <87zhz9936y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/21] docker: add env parser to
 docker.py build step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> We need to pass environment variables down to the debbootstrap.pre
> script to be able to specify build parameters.

This is stale, we don't need it as we inherit the environment set by the
calling make.

--
Alex Benn=C3=A9e
