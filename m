Received: from eggs.gnu.org ([209.51.188.92]:54891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr7Vh-0005jp-S9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr7Ge-00075l-Lj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:24:30 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr7Gb-00073A-70
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:24:26 -0500
Received: by mail-wr1-f47.google.com with SMTP id z15so3097202wrn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 12:24:22 -0800 (PST)
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
	<1549305379-51117-8-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <feaf8f3c-2517-741a-7875-8cf7b75ae0a3@redhat.com>
Date: Tue, 5 Feb 2019 21:24:19 +0100
MIME-Version: 1.0
In-Reply-To: <1549305379-51117-8-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 07/77] tap: flush STDOUT on newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 2/4/19 7:35 PM, Paolo Bonzini wrote:
> This makes it easier to follow what is going on.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This one also misses:
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
