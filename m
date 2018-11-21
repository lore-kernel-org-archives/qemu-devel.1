Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXOQ-0000K9-9q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXOL-000397-L2
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:38:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPXOK-00033z-3w
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:38:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so6743787wmf.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:38:22 -0800 (PST)
References: <20181121182725.4263-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a8dd805-7ec7-1cf5-afc3-ac78d54b1501@redhat.com>
Date: Wed, 21 Nov 2018 19:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181121182725.4263-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: g_test_message does not need a
 a trailing newline
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



On 21/11/18 19:27, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/checkpatch.pl | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eccd656c41..d27bc51f8c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2802,7 +2802,8 @@ sub process {
>   				info_vreport|
>   				error_report|
>   				warn_report|
> -				info_report}x;
> +				info_report|
> +                                g_test_message}x;

This perl file use <tab> here, shouldn't we keep the same style?

>   
>   	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>   		ERROR("Error messages should not contain newlines\n" . $herecurr);
> 

$ ./scripts/checkpatch.pl -f tests/ipmi-bt-test.c
ERROR: Error messages should not contain newlines
#408: FILE: tests/ipmi-bt-test.c:408:
+        g_test_message("Skipping test for non-x86\n");
total: 1 errors, 0 warnings, 430 lines checked

Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
