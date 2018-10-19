Received: from eggs.gnu.org ([2001:4830:134:3::10]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDPgT-0001n9-8i
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDPgP-0005YM-Oi
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:59:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDPgP-0005QS-Ae
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:58:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so570598wrn.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 00:58:56 -0700 (PDT)
References: <20181018145748.11697-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8442a17-9ac1-27d7-d374-4f10f493f92a@redhat.com>
Date: Fri, 19 Oct 2018 09:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <20181018145748.11697-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [web PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 18/10/2018 16:57, Daniel P. Berrangé wrote:
> This adds a config file for git-publish, primarily so that patches get
> sent with the "web" subject prefix to distinguish them from patches to
> the main git repo.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> I picked Paolo & Thomas as CC since they appear to be the people
> actually committing patches to qemu-web.git so far. Feel free to
> correct me if needed...
> 
>  .gitpublish | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 .gitpublish
> 
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000..4cf08bc
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,11 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU upstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "default"]
> +base = master
> +to = qemu-devel@nongnu.org
> +prefix = web PATCH
> +cc = Paolo Bonzini <pbonzini@redhat.com>
> +cc = Thomas Huth <thuth@redhat.com>
> 

Pushed, thanks.

Paolo
