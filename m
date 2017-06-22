Received: from eggs.gnu.org ([2001:4830:134:3::10]:39603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dO4VC-0003LU-12
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dO4V8-0001IY-Vb
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dO4V8-0001Dg-Ow
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4AC4142866
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 15:58:32 +0000 (UTC)
Received: from [10.43.2.192] (unknown [10.43.2.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28F1261F4C
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 15:58:31 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
Message-ID: <d627afbc-5cd8-d831-d089-d1fb30fbfdfd@redhat.com>
Date: Thu, 22 Jun 2017 17:58:30 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu-bridge-helper with SUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 05/30/2017 10:23 AM, Michal Privoznik wrote:
> For more description see patch 3. Long story short, if the bridge helper runs
> with SUID, the mechanism we rely on (DAC denying access to ACL files) does not
> work.
> 
> Michal Privoznik (3):
>   qemu-bridge-helper: Reverse return value setting logic
>   qemu-bridge-helper: Reverse return value setting logic in
>     parse_acl_file
>   qemu-bridge-helper: Take ACL file gid into account
> 
>  qemu-bridge-helper.c | 79 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
> 

ping?

Michal
