Received: from eggs.gnu.org ([2001:4830:134:3::10]:44697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSYIM-0008Ts-9H
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSYIH-0001n9-8I
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:12:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:42607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gSYIG-0001kx-3k
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:12:37 -0500
Message-ID: <dd8d533ccca622cc4455e14e8a4776ee700b00ef.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2018 13:12:08 +1100
In-Reply-To: <b8130aae-5158-bb31-73c0-82beee0ad176@linaro.org>
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
	<408ef3b1c0bab7d26cffeb366a5ee87bb8448fa4.camel@kernel.crashing.org>
	<b8130aae-5158-bb31-73c0-82beee0ad176@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Thu, 2018-11-29 at 16:12 -0800, Richard Henderson wrote:
> > You mean translating once for the load and for the udpate ? Do you
> > expect that translation to have such a significant cost considering
> > that all it needs should be in L1 at that point ?
> 
> I guess if the update is rare-ish, the re-translating isn't a big deal.  And I
> suppose we'd have to retain the RCU lock to hold on to the translation, which
> probably isn't the best idea.

Yeay I toyed with this a bit but it ended up very messy real quick.

Cheers,
Ben.
