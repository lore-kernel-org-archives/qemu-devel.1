Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSUho-00021x-L7
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 15:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSUhn-00045u-RQ
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 15:13:40 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cSUhn-00045k-KJ
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 15:13:39 -0500
Received: by mail-pg0-x242.google.com with SMTP id 204so1596316pge.2
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 12:13:39 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170111021820.24416-1-rth@twiddle.net>
	<20170111021820.24416-15-rth@twiddle.net>
	<7763a9ed-0a79-83fc-cb0e-324b86d05297@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <697adb36-4b40-7011-74f2-fb35349b1e64@twiddle.net>
Date: Sat, 14 Jan 2017 12:13:35 -0800
MIME-Version: 1.0
In-Reply-To: <7763a9ed-0a79-83fc-cb0e-324b86d05297@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 14/65] target-arm: Use new deposit and
 extract ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 01/14/2017 11:41 AM, Laszlo Ersek wrote:
> On 01/11/17 03:17, Richard Henderson wrote:
>> Use the new primitives for UBFX and SBFX.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/arm/translate-a64.c | 81 +++++++++++++++++-----------------------------
>>  target/arm/translate.c     | 37 +++++----------------
>>  2 files changed, 37 insertions(+), 81 deletions(-)
>
> This patch causes an assertion to fail:
>
>> qemu-system-aarch64: .../tcg/tcg-op.c:1829: tcg_gen_deposit_z_i64: Assertion `ofs + len <= 64' failed.
>
> See the details below.

Please try again with

   http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02734.html


r~
