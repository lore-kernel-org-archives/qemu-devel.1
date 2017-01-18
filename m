Received: from eggs.gnu.org ([2001:4830:134:3::10]:49763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTjT5-0007Eb-34
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTjT1-0004FG-Us
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:11:35 -0500
References: <1484709722-3546-1-git-send-email-skiver.cloud.yzy@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1485fb07-3948-f5a5-439c-9db721fb50de@redhat.com>
Date: Wed, 18 Jan 2017 07:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <1484709722-3546-1-git-send-email-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] gdbstub.c: update old error report
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>

On 18.01.2017 04:22, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
> 
> Some updates from fprintf(stderr, ...) to error_report.
> 
> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
> ---
>  gdbstub.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 426d55e..fe1d0f8 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -637,8 +637,8 @@ void gdb_register_coprocessor(CPUState *cpu,
>      *p = s;
>      if (g_pos) {
>          if (g_pos != s->base_reg) {
> -            fprintf(stderr, "Error: Bad gdb register numbering for '%s'\n"
> -                    "Expected %d got %d\n", xml, g_pos, s->base_reg);
> +            error_report("Error: Bad gdb register numbering for '%s', "
> +                         "Expected %d got %d", xml, g_pos, s->base_reg);

Since the message is now printed in one line with a comma in between,
I'd maybe rather write "expected" without capital letter.

 Thomas
