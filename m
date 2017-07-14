Received: from eggs.gnu.org ([2001:4830:134:3::10]:59990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVv5C-0006Iw-KC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVv57-0004Py-P9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVv57-0004OM-Id
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DC294E326
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:32:08 +0000 (UTC)
References: <cover.1496132443.git.mprivozn@redhat.com>
	<d627afbc-5cd8-d831-d089-d1fb30fbfdfd@redhat.com>
	<03f93e78-b585-6d01-2c63-5de8dac97abe@redhat.com>
	<20170711145456.GT7116@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f9b427a0-c234-dfe1-a515-6e3e0428a725@redhat.com>
Date: Fri, 14 Jul 2017 15:31:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170711145456.GT7116@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu-bridge-helper with SUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8811=E6=97=A5 22:54, Daniel P. Berrange wrote:
> On Tue, Jul 11, 2017 at 03:10:43PM +0200, Michal Privoznik wrote:
>> On 06/22/2017 05:58 PM, Michal Privoznik wrote:
>>> On 05/30/2017 10:23 AM, Michal Privoznik wrote:
>>>> For more description see patch 3. Long story short, if the bridge he=
lper runs
>>>> with SUID, the mechanism we rely on (DAC denying access to ACL files=
) does not
>>>> work.
>>>>
>>>> Michal Privoznik (3):
>>>>    qemu-bridge-helper: Reverse return value setting logic
>>>>    qemu-bridge-helper: Reverse return value setting logic in
>>>>      parse_acl_file
>>>>    qemu-bridge-helper: Take ACL file gid into account
>>>>
>>>>   qemu-bridge-helper.c | 79 ++++++++++++++++++++++++++++------------=
------------
>>>>   1 file changed, 42 insertions(+), 37 deletions(-)
>>>>
>>> ping?
>>>
>> ping^2?

Applied.

> Sigh, this is one of the files for which we have no nominated maintaine=
r
> listed, so it easily falls through the cracks.
>
> Since this is network related, I wonder if Jason should be listed in th=
e
> MAINTAINERS file for this. Or perhaps we should move the qemu-bridge-he=
lper.c
> file into the net/ sub-directory instead ?

Let me claim this in MAINTAINERS.

Thanks

>
> Regards,
> Daniel
