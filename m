Received: from eggs.gnu.org ([2001:4830:134:3::10]:33848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXuUk-00048Y-9b
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXuUh-0002jY-1M
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:55:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXuUg-0002j4-Qy
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:55:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t6so6512986wrr.12
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:55:34 -0800 (PST)
References: <20181214135452.25936-1-alex.bennee@linaro.org>
	<20181214135452.25936-2-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181214135452.25936-2-alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 20:55:32 +0000
Message-ID: <87bm5n25h7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 01/15] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:
<snip>
> +# Also group together our prolific individual contributors
> +# and those working under academic auspices
> +GroupMap contrib/gitdm/group-map-individuals (None)
> +GroupMap contrib/gitdm/group-map-academics Academics (various)

Have sent v4 for these two files. I'll make a new PR on Monday.

> +
> +#
> +#
> +# Use FileTypeMap to map a file types to file names using regular
> +# regular expressions.
> +#
> +FileTypeMap contrib/gitdm/filetypes.txt


--
Alex Benn=C3=A9e
