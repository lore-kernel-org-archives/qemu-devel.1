Received: from eggs.gnu.org ([2001:4830:134:3::10]:39190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdNb-0006V3-KN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdNa-00045O-TD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:23:55 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFdNa-000456-KG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:23:54 -0400
Received: by mail-wm0-x22f.google.com with SMTP id e127so91362356wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:23:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E2A0E2A-7A9D-4340-8FC8-A2B0C9DB8271@gmail.com>
References: <4E2A0E2A-7A9D-4340-8FC8-A2B0C9DB8271@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 10:23:32 +0100
Message-ID: <CAFEAcA-05x+873vD7Yz2RaBsY=bwMvmj35JDfpLH1CDrjxPFPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] risugen: test only instructions that begin with
 the letter F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 4 May 2017 at 20:39, G 3 <programmingkidx@gmail.com> wrote:
> I'm trying to test all the floating point instructions only. They tend to
> begin with the letter f. Is there a way to have risugen only use
> instructions that begin with the letter F?

Yes, use the --pattern option with a suitable
regular expression. (in this case --pattern 'F.*')

thanks
-- PMM
