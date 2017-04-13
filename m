Received: from eggs.gnu.org ([2001:4830:134:3::10]:36519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyX0m-00013S-2p
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 01:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyX0l-0003qT-9n
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 01:09:40 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-6-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56cc09de-8ce4-f264-195a-393387e28ec0@redhat.com>
Date: Thu, 13 Apr 2017 13:09:12 +0800
MIME-Version: 1.0
In-Reply-To: <1491959850-30756-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] tcg: add jr opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, Claudio Fontana <claudio.fontana@huawei.com>, Alexander Graf <agraf@suse.de>, alex.bennee@linaro.org, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>



On 12/04/2017 09:17, Emilio G. Cota wrote:
> This will be used by TCG targets to implement a fast path
> for indirect branches.
> 
> I only have implemented and tested this on an i386 host, so
> make this opcode optional and mark it as not implemented by
> other TCG backends.

Please don't forget to document this in tcg/README.

Thanks,

Paolo
