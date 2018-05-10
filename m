Received: from eggs.gnu.org ([2001:4830:134:3::10]:35019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmnC-00025V-Rp
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmn9-0002eq-MZ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:43:38 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:34611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fGmn9-0002eY-GK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:43:35 -0400
Received: by mail-pg0-x22d.google.com with SMTP id g20-v6so1073374pgv.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:43:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180510143618.23673-1-peter.maydell@linaro.org>
	<d4525d99-e8cd-e56b-e23e-d486cb9f57ef@twiddle.net>
	<CAFEAcA8V_Zb3kHThShPQshC4=wt2Oof=VoVU35C0-TyusGzC_w@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <73b20cd6-4b4f-a060-8c37-e9df9793e44b@twiddle.net>
Date: Thu, 10 May 2018 07:43:32 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8V_Zb3kHThShPQshC4=wt2Oof=VoVU35C0-TyusGzC_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Work around gcc spurious "unused
 value" warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2018 07:38 AM, Peter Maydell wrote:
> Thanks. Do we care about trying to follow up on the gcc side
> to find out if this is a definitely-fixed bug?

Given I did not see the problem with gcc 6 as shipped with debian 9, I'm not
overly inclined to dig further than that.


r~
