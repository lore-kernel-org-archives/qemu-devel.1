Received: from eggs.gnu.org ([2001:4830:134:3::10]:44701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1Zm-0000v5-EL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1Zg-00064S-Pw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:01:10 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:39433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb1Zg-00064B-KT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:01:04 -0500
Received: by mail-ot0-x229.google.com with SMTP id 37so10163833otv.6
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:01:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QfZBfujPdZ+n89x6rF0m7ohz+KsVX527d4xMnOu-5XA@mail.gmail.com>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-9-richard.henderson@linaro.org>
	<CAFEAcA8QfZBfujPdZ+n89x6rF0m7ohz+KsVX527d4xMnOu-5XA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 10:00:43 +0000
Message-ID: <CAFEAcA8e7BDCW5nF_SzrnUTGZJiRoUnMZ5APG=g7rOPCzRXM+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Add ZCR.LEN to tb->flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 January 2018 at 18:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> For purposes of not having to mess with migration state too frequently,
> I think this patch should define zcr_el[4] (and add that to the
> migration subsection for 'has SVE').

I realized over the weekend that this suggestion isn't right --
ZCR_ELx are sysregs accessible via the usual msr/mrs, so they'll
be migrated via the sysreg migration mechanism, not with
explicit fields in the migration structs. So I think we're
OK to leave this as TODO for the moment.

thanks
-- PMM
