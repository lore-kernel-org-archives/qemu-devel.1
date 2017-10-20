Received: from eggs.gnu.org ([2001:4830:134:3::10]:58056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NxT-0003kS-Ih
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NxS-00024T-Ga
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:26:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<9aee5a95c03d6cb4f4ba6359828809ceab535bfb.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f0c582f1-f524-1719-637f-362a8d7483fb@amsat.org>
Date: Fri, 20 Oct 2017 00:25:58 -0300
MIME-Version: 1.0
In-Reply-To: <9aee5a95c03d6cb4f4ba6359828809ceab535bfb.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 46/46] target: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, alistair23@gmail.com, Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 10/19/2017 01:18 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Acked-by: Cornelia Huck <cohuck@redhat.com> (s390x part)

I was not sure commenting after the mail would break scripts, but it
doesn't appear to, good to know!

http://patchwork.ozlabs.org/patch/828257/  <- parsed correctly
