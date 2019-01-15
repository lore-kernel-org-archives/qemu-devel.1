Received: from eggs.gnu.org ([209.51.188.92]:52675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTwA-0007QT-Ef
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTw8-00082G-VC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:46 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjTw8-0007xw-Ji
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:44 -0500
Received: by mail-wm1-f50.google.com with SMTP id r24so1741618wmh.0
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:59:38 -0800 (PST)
References: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f3a03f92-a71b-2032-2a81-715d222d0cf5@redhat.com>
Date: Tue, 15 Jan 2019 19:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tap: flush STDOUT on newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 1/15/19 6:56 PM, Paolo Bonzini wrote:
> This makes it easier to follow what is going on.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/tap-driver.pl | 1 +
>  scripts/tap-merge.pl  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
> index 5e59b5d..6621a5c 100755
> --- a/scripts/tap-driver.pl
> +++ b/scripts/tap-driver.pl
> @@ -313,6 +313,7 @@ sub main ()
>    my $iterator = TAP::Parser::Iterator::Stream->new(\*STDIN);
>    my $parser = TAP::Parser->new ({iterator => $iterator });
>  
> +  STDOUT->autoflush(1);
>    while (defined (my $cur = $parser->next))
>      {
>        # Parsing of TAP input should stop after a "Bail out!" directive.
> diff --git a/scripts/tap-merge.pl b/scripts/tap-merge.pl
> index 59e3fa5..10ccf57 100755
> --- a/scripts/tap-merge.pl
> +++ b/scripts/tap-merge.pl
> @@ -53,6 +53,7 @@ sub main ()
>    my $testno = 0;     # Number of test results seen so far.
>    my $bailed_out = 0; # Whether a "Bail out!" directive has been seen.
>  
> +  STDOUT->autoflush(1);
>    while (defined (my $cur = $parser->next))
>      {
>        if ($cur->is_bailout)
> 
