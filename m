Received: from eggs.gnu.org ([2001:4830:134:3::10]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWIQp-0001TN-Ra
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWIQl-0002ao-V6
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:07 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWIQl-0002ae-Pm
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:03 -0400
Received: by mail-qk0-x244.google.com with SMTP id a66so13867203qkb.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 01:28:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-3-rth@twiddle.net>
	<fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
	<20170714210853.ofowponstnf6ncgo@aurel32.net>
	<744dddb8-a3b7-c82a-656a-f01ebf21a3d5@twiddle.net>
	<20170715082522.z4tyjqm2lyklgfew@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9acc18b6-a635-ab58-ee69-261e3718dc73@twiddle.net>
Date: Fri, 14 Jul 2017 22:27:57 -1000
MIME-Version: 1.0
In-Reply-To: <20170715082522.z4tyjqm2lyklgfew@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, david@redhat.com

On 07/14/2017 10:25 PM, Aurelien Jarno wrote:
> That said I still wonder if we can get generators like that:
> 
> | static void in1_r1n(DisasContext *s, DisasFields *f, DisasOps *o)
> | {
> |     int r1 = get_field(s->fields, r1);
> |     o->in1 = tcg_const_i32(r1);
> |
> | #define SPEC_in1_r1n 0
> 
> and
> 
> | static void in1_r1n_even(DisasContext *s, DisasFields *f, DisasOps *o)
> | {
> |     int r1 = get_field(s->fields, r1);
> |     o->in1 = tcg_const_i32(r1);
> |
> | #define SPEC_in1_r1n_even SPEC_r1_even

Well, not in to o->in1, obviously, since that's TCGv_i32 not TCGv_i64.
I suppose we could add something of the sort though.


r~
