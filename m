Received: from eggs.gnu.org ([2001:4830:134:3::10]:39259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVmN-0004tP-SF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVmJ-000574-4A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:35 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciVmI-00056z-Ud
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:31 -0500
Received: by mail-qk0-x243.google.com with SMTP id r90so21128689qki.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:36:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170227085353.20787-1-mbenes@suse.cz>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cfd1bc58-6eb8-1385-0474-237b655d1760@twiddle.net>
Date: Tue, 28 Feb 2017 11:36:24 +1100
MIME-Version: 1.0
In-Reply-To: <20170227085353.20787-1-mbenes@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miroslav Benes <mbenes@suse.cz>, agraf@suse.de
Cc: thuth@redhat.com, ebischoff@suse.com, mmarek@suse.com, qemu-devel@nongnu.org

On 02/27/2017 07:53 PM, Miroslav Benes wrote:
> Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
> available in facilities list provided by stfl/stfle instruction. This is
> the case of newer z/System generations and their qemu definition.
>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
> v2
> - remove potential_page_fault()
>
>  target/s390x/insn-data.def | 2 ++
>  target/s390x/translate.c   | 9 +++++++++
>  2 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
