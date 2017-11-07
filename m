Received: from eggs.gnu.org ([2001:4830:134:3::10]:38063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eC2mO-0004cT-I1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eC2mM-0000Fr-Aa
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:14:56 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
	<1a04d2a2-98cc-5ef7-ace4-6836a1c9ec94@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <430a5ef2-99ff-03e2-c3e3-01448e1862b9@twiddle.net>
Date: Tue, 7 Nov 2017 13:14:31 +0100
MIME-Version: 1.0
In-Reply-To: <1a04d2a2-98cc-5ef7-ace4-6836a1c9ec94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] target-s390x: assertion failure in op_risbg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On 11/07/2017 01:00 PM, Thomas Huth wrote:
> If I've got the spec right, it's doing the same as
> RISBG (with subcode 0x55), but just does not set the condition code at
> the end, so this should be quite easy to implement?

That's right.


r~
