Received: from eggs.gnu.org ([2001:4830:134:3::10]:34282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIsa-0002G9-R7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIsV-0000Fc-5A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:00:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fRIsU-0000FH-Qe
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:00:34 -0400
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<edcae62f-e3b6-6e25-60a5-843eeae89396@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4865a48e-2653-b077-6656-acc5f1b49def@redhat.com>
Date: Fri, 8 Jun 2018 10:00:32 -0500
MIME-Version: 1.0
In-Reply-To: <edcae62f-e3b6-6e25-60a5-843eeae89396@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu PATCH 1/5] gitignore: ignore generated qapi
 job files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 06/08/2018 09:59 AM, Eric Blake wrote:
> On 06/07/2018 05:31 PM, Ross Zwisler wrote:
>> With a fully built QEMU I currently see the following with "git status=
":
>>
>> =C2=A0=C2=A0 Untracked files:
>> =C2=A0=C2=A0=C2=A0=C2=A0 (use "git add <file>..." to include in what w=
ill be committed)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-commands-job.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-commands-job.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-events-job.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-events-job.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-types-job.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-types-job.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-visit-job.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/qapi-visit-job.h
>>
>> These are all generated files.=C2=A0 Ignore them.
>>
>> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Fixes: commit bf42508f24ee ("job: Introduce qapi/job.json")
>=20
> You're the third to post this:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07280.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01624.html

Also, when sending a series, it's best to include a 0/5 cover letter=20
(the automated CI tooling handles that better, among other reasons).=20
You can use 'git config' to automatically send a cover letter for any=20
patch series > 1.  For more tips,=20
https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
