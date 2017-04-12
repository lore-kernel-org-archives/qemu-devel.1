Received: from eggs.gnu.org ([2001:4830:134:3::10]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy9CK-0005dP-T9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy9CK-00024d-3e
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:44:00 -0400
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-10-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ede0852-6888-8bcb-ac5a-363478841bc7@redhat.com>
Date: Wed, 12 Apr 2017 11:43:45 +0800
MIME-Version: 1.0
In-Reply-To: <1491959850-30756-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/10] target/i386: optimize indirect
 branches with TCG's jr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>



On 12/04/2017 09:17, Emilio G. Cota wrote:
> 
> The fact that NBench is not very sensitive to changes here is a
> little surprising, especially given the significant improvements for
> ARM shown in the previous commit. I wonder whether the compiler is doing
> a better job compiling the x86_64 version (I'm using gcc 5.4.0), or I'm simply
> missing some i386 instructions to which the jr optimization should
> be applied.

Maybe it is "ret"?  That would be a straightforward "bx lr" on ARM, but
it is missing in your i386 patch.

Paolo
