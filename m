Received: from eggs.gnu.org ([2001:4830:134:3::10]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLxJ-0006tf-5R
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLx9-0000q3-Td
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daLx9-0000pC-NI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:02:15 -0400
References: <1501073992-6297-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <268cd245-b5ce-7945-27c8-eeaabf6bfd04@redhat.com>
Date: Wed, 26 Jul 2017 15:02:10 +0200
MIME-Version: 1.0
In-Reply-To: <1501073992-6297-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Change the "Full list of
 releases" link to point to download.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Jeff Cody <jcody@redhat.com>

On 26/07/2017 14:59, Thomas Huth wrote:
> The list in the Wiki is not up to date anymore, so let's simply point
> the users to the file list on the download server instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  _includes/releases.html | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/_includes/releases.html b/_includes/releases.html
> index 226c719..683d552 100644
> --- a/_includes/releases.html
> +++ b/_includes/releases.html
> @@ -7,4 +7,4 @@
>    href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
>  {% endfor %}
>  </ul>
> -<p><a {% if page.url == '/' %}class="button"{%endif%} href="http://wiki.qemu-project.org/Main_Page#News">Full list of releases</a><p>
> +<p><a {% if page.url == '/' %}class="button"{%endif%} href="http://download.qemu.org/">Full list of releases</a><p>
> 

Sounds good.  Later we can change it to download.qemu.org/releases.

Paolo
