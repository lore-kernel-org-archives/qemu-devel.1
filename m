Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIHQy-0004de-Pm
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIHQu-0005cD-5o
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:34:20 -0400
References: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676554488.4134.16095044562334102742.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52f605ab-1586-d365-39c5-4dd8109f3126@redhat.com>
Date: Tue, 6 Jun 2017 18:34:11 +0200
MIME-Version: 1.0
In-Reply-To: <149676554488.4134.16095044562334102742.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: pass const string to
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06.06.2017 18:12, Greg Kurz wrote:
> This function has three implementations. Two are stubs that do nothing
> and the third one only passes the obj_path argument to:
>=20
> Object *object_resolve_path(const char *path, bool *ambiguous);
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: - also patch inline stub
>     - renamed patch and added changelog
> ---
>  target/ppc/kvm.c     |    4 ++--
>  target/ppc/kvm_ppc.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
