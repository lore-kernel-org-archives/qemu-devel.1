Received: from eggs.gnu.org ([2001:4830:134:3::10]:59407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3KH-00021Q-Hp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3KE-0001pT-C5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:46:37 -0400
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
	<1504099475-241036-9-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69765b5d-273d-c695-9094-049e0a486718@redhat.com>
Date: Wed, 30 Aug 2017 15:46:30 +0200
MIME-Version: 1.0
In-Reply-To: <1504099475-241036-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 8/8] ppc: remove non
 implemented cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30.08.2017 15:24, Igor Mammedov wrote:
> Remove cpu models that aren't implemented and are not
> compiled/tested since they are under TODO ifdef
> which isn't defined in sources.
> 
> If someone really needs a removed model he/she should add
> as regular one with corresponding implementation.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/ppc/cpu-models.c | 459 ------------------------------------------------
>  1 file changed, 459 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index cf878a9..611fc1b 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -19,11 +19,6 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
[...]
>      /* PowerPC 440 family                                                    */
> -#if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
> -                "Generic PowerPC 440")
> -#endif

Please don't remove this TODO_USER_ONLY entry. It's still used if the
code is compiled with CONFIG_USER_ONLY.

 Thomas
