Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fFjez-0003tQ-1O
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fFjev-0003u4-RY
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:10:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fFjev-0003s9-J7
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:10:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w47H9x5O138593
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 13:10:44 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2htqdv28cb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 13:10:44 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 7 May 2018 13:10:43 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
	<7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
	<7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
	<89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
	<724592be-f5ac-7a40-8c26-5d2dd200ef82@linux.ibm.com>
	<ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
	<d37855b8-1dcd-04fe-fe80-3dcd609bded4@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 7 May 2018 13:10:40 -0400
MIME-Version: 1.0
In-Reply-To: <d37855b8-1dcd-04fe-fe80-3dcd609bded4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <1d7bfb27-b596-efe1-9c1a-a7ddc14d1a78@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] monitor: report entirety of hmp command
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 05/07/2018 12:44 PM, Eric Blake wrote:
> On 05/07/2018 09:30 AM, Collin Walling wrote:
>> When a user incorrectly provides an hmp command, an error response wil=
l be
>> printed that prompts the user to try "help <command name>". However, w=
hen
>> the command contains multiple parts e.g. "info uuid xyz", only the las=
t
>> whitespace delimited string will be reported (in this example "info" w=
ill
>> be dropped and the message will read "Try "help uuid" for more informa=
tion",
>> which is incorrect).
>>
>> Let's correct this by capturing the entirety of the command from the c=
ommand
>> line -- excluding any extraneous characters.
>>
>=20
> It's better to post a v2 patch as a new top-level thread instead of in-=
reply to an earlier version, as some of our automated tooling is more lik=
ely to see it.
>=20
>> Reported-by: Mikhail Fokin <fokin@de.ibm.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>> =C2=A0 monitor.c | 8 ++++++--
>> =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Noted. And thank you for the r-b.

--=20
Respectfully,
- Collin Walling
