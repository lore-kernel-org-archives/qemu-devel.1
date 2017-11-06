Received: from eggs.gnu.org ([2001:4830:134:3::10]:50605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eBlWr-0007q8-S8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eBlWn-0003lf-PQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:49:45 -0500
References: <20171019075031.25507-1-rjones@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <5888e39b-8f55-2d6b-afbe-da4727f23c2d@msgid.tls.msk.ru>
Date: Mon, 6 Nov 2017 20:49:28 +0300
MIME-Version: 1.0
In-Reply-To: <20171019075031.25507-1-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tpm: Don't call tpm_cleanup unless
 CONFIG_TPM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com

19.10.2017 10:50, Richard W.M. Jones wrote:
> When compiling with --disable-tpm:
> 
>   ../vl.o: In function `main':
>   /home/rjones/d/qemu/vl.c:4908: undefined reference to `tpm_cleanup'
> 
> This appears to have been introduced in commit c37cacabf228
> ("tpm: Move tpm_cleanup() to right place").
> 

> index 0723835bbf..dbfd06d4bc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>      res_free();
>  
>      /* vhost-user must be cleaned up before chardevs.  */
> +#ifdef CONFIG_TPM
>      tpm_cleanup();
> +#endif

Maybe we can define it to an empty macro (or inline function) in
the header file instead?

/mjt
