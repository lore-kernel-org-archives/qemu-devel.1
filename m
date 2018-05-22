Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5ik-0003hC-4D
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5ih-0006iH-1E
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:44:50 -0400
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-2-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ca9fe21d-91de-808a-ad38-4f136536432b@redhat.com>
Date: Tue, 22 May 2018 13:44:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/5] qapi: Change "since 2.13"
 annotations to "since 3.0"
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

On 22.05.2018 12:39, Peter Maydell wrote:
> We're going to make the next release be 3.0, not 2.13; change
> the annotations in our json appropriately.
> 
> Changes produced with
>   sed -i -e 's/2\.13/3.0/g' qapi/*.json
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json |  4 ++--
>  qapi/common.json     |  2 +-
>  qapi/migration.json  | 16 ++++++++--------
>  qapi/misc.json       |  4 ++--
>  qapi/net.json        |  2 +-
>  qapi/ui.json         |  2 +-
>  6 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
