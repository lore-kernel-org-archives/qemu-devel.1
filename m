Received: from eggs.gnu.org ([2001:4830:134:3::10]:55368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fKb2B-0004Lz-B9
	for qemu-devel@nongnu.org; Sun, 20 May 2018 22:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fKb26-0001Vi-Em
	for qemu-devel@nongnu.org; Sun, 20 May 2018 22:58:51 -0400
References: <1526401580-20535-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a7297881-4e9b-4a41-d7e8-553afa47ce60@redhat.com>
Date: Mon, 21 May 2018 10:58:39 +0800
MIME-Version: 1.0
In-Reply-To: <1526401580-20535-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi/net.json: Fix the version number of
 the "vlan" removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org



On 2018=E5=B9=B405=E6=9C=8816=E6=97=A5 00:26, Thomas Huth wrote:
> "vlan" will be dropped in 2.13, not in 2.12. And while we're at it,
> use the better wording "dropped in" instead of "removed with" (also
> for the "dump" removal).
>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qapi/net.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/net.json b/qapi/net.json
> index b4fe4b6..b8adf1f 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -450,7 +450,7 @@
>   #
>   # Since: 2.7
>   #
> -# 'dump' - removed with 2.12
> +# 'dump': dropped in 2.12
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> @@ -498,7 +498,7 @@
>   #
>   # Since: 1.2
>   #
> -# 'vlan' - removed with 2.12
> +# 'vlan': dropped in 2.13
>   ##
>   { 'struct': 'NetLegacy',
>     'data': {

Applied.

Thanks
