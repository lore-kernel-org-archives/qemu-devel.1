Received: from eggs.gnu.org ([209.51.188.92]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn0zv-0007PK-U8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn0r1-0006qs-AU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:45:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn0r1-0006qa-3p
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:45:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so10128046wrs.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 04:45:03 -0800 (PST)
References: <1548410602-16008-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa3b6ce0-0fc4-7ee8-653b-5c0aecfa6d30@redhat.com>
Date: Fri, 25 Jan 2019 13:45:00 +0100
MIME-Version: 1.0
In-Reply-To: <1548410602-16008-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] decodetree: re.fullmatch was added in 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Cc'ing maintainers :P

$ ./scripts/get_maintainer.pl -f scripts/decodetree.py
Eduardo Habkost <ehabkost@redhat.com> (odd fixer:Python scripts)
Cleber Rosa <crosa@redhat.com> (odd fixer:Python scripts)

On 1/25/19 11:03 AM, Paolo Bonzini wrote:
> Python 3 versions earlier than 3.4 do not have it, use the
> same workaround that is in place for 3.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/decodetree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 0bc73b5..e342d27 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -204,7 +204,7 @@ def output(*args):
>          output_fd.write(a)
>  
>  
> -if sys.version_info >= (3, 0):
> +if sys.version_info >= (3, 4):
>      re_fullmatch = re.fullmatch
>  else:
>      def re_fullmatch(pat, str):
> 
