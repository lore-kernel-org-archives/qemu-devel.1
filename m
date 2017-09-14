Received: from eggs.gnu.org ([2001:4830:134:3::10]:46629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWp4-0006mX-PV
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWp1-00008m-JD
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:17:02 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dsWp1-000087-Di
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:16:59 -0400
Received: by mail-pg0-x241.google.com with SMTP id m30so1926967pgn.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:16:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506107741.19604.8328467942268087647.stgit@frigg.lan>
	<3fb9d3ac-db86-2ff7-d6e1-988982d1eb18@linaro.org>
	<8760clpaqv.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e1370c9b-0807-07d6-ff39-f3473933e3dd@twiddle.net>
Date: Thu, 14 Sep 2017 09:16:56 -0700
MIME-Version: 1.0
In-Reply-To: <8760clpaqv.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] trace: Add event "guest_bbl_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/14/2017 08:20 AM, Lluís Vilanova wrote:
>> I don't understand why you wouldn't just modify tcg_gen_goto_tb and
>> tcg_gen_exit_tb instead.
> 
> I prefer to keep all generic translation-related tracing on a single file, where
> it is easier to reason about.

My point here was more about the inline_points.  Discussed elsewhere now.


r~
