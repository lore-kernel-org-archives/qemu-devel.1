Received: from eggs.gnu.org ([2001:4830:134:3::10]:36973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJPB1-0004xM-3d
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 14:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJPAy-0004za-0u
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 14:34:47 -0500
References: <20171127174944.12362-1-vapier@gentoo.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c0cecdb2-6d20-b229-a92a-110721fc2bbf@redhat.com>
Date: Mon, 27 Nov 2017 14:34:41 -0500
MIME-Version: 1.0
In-Reply-To: <20171127174944.12362-1-vapier@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Frysinger <vapier@gentoo.org>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>



On 11/27/2017 12:49 PM, Mike Frysinger wrote:
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 030617b4ac0c..bc7224a27fe3 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -24,7 +24,7 @@ error() {
>      echo "Alternatively you may disable automatic GIT submodule checkout"
>      echo "with:"
>      echo
> -    echo " $ ./configure --disable-git-update'"
> +    echo " $ ./configure --disable-git-update"
>      echo
>      echo "and then manually update submodules prior to running make, with:"
>      echo
> 

cc qemu-trivial

Reviewed-by: John Snow <jsnow@redhat.com>
