Received: from eggs.gnu.org ([208.118.235.92]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egccY-0006Hw-Rp
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egcZL-0005J6-ML
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:32:57 -0500
References: <2a250f8d59f1eedd7728d94a9dae1a6de54d0c14.1517340741.git.crobinso@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58c4c86f-a9a7-a2bc-4d4f-ce331334abba@redhat.com>
Date: Tue, 30 Jan 2018 21:31:45 +0100
MIME-Version: 1.0
In-Reply-To: <2a250f8d59f1eedd7728d94a9dae1a6de54d0c14.1517340741.git.crobinso@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] scripts/make-release: Don't archive
 .git files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 30.01.2018 20:33, Cole Robinson wrote:
> As was last done in 379e21c25, we don't want .git files for
> submodules here, which we aren't presently doing for capstone and
> keycodemapdb.
> 
> Rather than delete the offending files before archiving, ask tar
> to --exclude=.git
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
> v2:
>     Use armbru's --exclude suggestion, requires tweaking
>     existing tar options a bit.
> 
> v3:
>     thuth's suggestion to use --exclude for both tar commands
> 
>  scripts/make-release | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/make-release b/scripts/make-release
> index 3917df7142..04fa9defdc 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,11 +19,10 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> -rm -rf .git roms/*/.git dtc/.git pixman/.git

Thanks, this also fixes the dead pixman/.git path :-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
