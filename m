Received: from eggs.gnu.org ([2001:4830:134:3::10]:53654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5mj-00069A-G0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5me-0008Oh-N2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:48:57 -0400
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-6-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <11af1172-67da-b896-754e-83b69339e782@redhat.com>
Date: Tue, 22 May 2018 13:48:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 5/5] qemu-doc.texi: Rename
 references to 2.13 to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22.05.2018 12:40, Peter Maydell wrote:
> Update references to 2.13 to read 3.0, since that's the
> number we're using for the next release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qemu-doc.texi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 0e0e0ae72b..cac1c3b39e 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2917,7 +2917,7 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
>  
>  The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
>  
> -@subsection -virtioconsole (since 2.13.0)
> +@subsection -virtioconsole (since 3.0.0)
>  
>  Option @option{-virtioconsole} has been replaced by
>  @option{-device virtconsole}.
> @@ -2940,7 +2940,7 @@ from qcow2 images.
>  
>  The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
>  
> -@subsection query-cpus-fast "arch" output member (since 2.13.0)
> +@subsection query-cpus-fast "arch" output member (since 3.0.0)
>  
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.

Reviewed-by: Thomas Huth <thuth@redhat.com>
