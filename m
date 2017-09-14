Received: from eggs.gnu.org ([2001:4830:134:3::10]:43768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWkq-0003q6-T2
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWkm-0003cW-UO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:12:40 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dsWkm-0003ab-Nq
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:12:36 -0400
Received: by mail-pf0-x231.google.com with SMTP id e1so4756836pfk.1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:12:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506059354.19604.5050182852156612042.stgit@frigg.lan>
	<0250ce97-bef3-1feb-d9a9-4e4a91084fa7@linaro.org>
	<87inglpbpu.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <80d88121-3a7d-12a2-11f0-f6b0f474c7b6@twiddle.net>
Date: Thu, 14 Sep 2017 09:12:30 -0700
MIME-Version: 1.0
In-Reply-To: <87inglpbpu.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] trace: Add event
 "guest_inst_info_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/14/2017 07:59 AM, Lluís Vilanova wrote:
> Since physical address information is not gonna be added in this series (if at
> all), what do you say about hoisting instruction length info into
> guest_insn_before/after and dropping the *_info variants?

That should be fine.


r~
