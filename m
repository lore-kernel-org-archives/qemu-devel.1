Received: from eggs.gnu.org ([2001:4830:134:3::10]:48887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTGLT-0000CR-Or
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTGLP-0002e1-Nk
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:05:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTGLP-0002du-C1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:05:43 -0500
References: <20170111021820.24416-1-rth@twiddle.net>
	<20170111021820.24416-15-rth@twiddle.net>
	<7763a9ed-0a79-83fc-cb0e-324b86d05297@redhat.com>
	<697adb36-4b40-7011-74f2-fb35349b1e64@twiddle.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <889d330d-922b-acff-a503-e9773d9b909d@redhat.com>
Date: Tue, 17 Jan 2017 00:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <697adb36-4b40-7011-74f2-fb35349b1e64@twiddle.net>
Content-Type: text/plain; charset=windows-1252
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 01/14/17 21:13, Richard Henderson wrote:
> On 01/14/2017 11:41 AM, Laszlo Ersek wrote:
>> On 01/11/17 03:17, Richard Henderson wrote:
>>> Use the new primitives for UBFX and SBFX.
>>>
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>> ---
>>>  target/arm/translate-a64.c | 81
>>> +++++++++++++++++-----------------------------
>>>  target/arm/translate.c     | 37 +++++----------------
>>>  2 files changed, 37 insertions(+), 81 deletions(-)
>>
>> This patch causes an assertion to fail:
>>
>>> qemu-system-aarch64: .../tcg/tcg-op.c:1829: tcg_gen_deposit_z_i64:
>>> Assertion `ofs + len <= 64' failed.
>>
>> See the details below.
> 
> Please try again with
> 
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02734.html

Right, with 86c9ab277615af4e0389eb80a83073873ff96c86 (and its neighbors)
in the build, the above (very-very early) assertion is gone.

Now I'm just waiting for Stefan's "[Qemu-devel] [PATCH 0/2] virtio:
revert virtio_queue_set_notification() nesting" to hit the tree, so that
the other assertion failure (re: "vq->notification_disabled > 0")
disappears too :)

Thank you,
Laszlo
