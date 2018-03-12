Received: from eggs.gnu.org ([2001:4830:134:3::10]:60676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO1R-0002yI-CU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO1L-00014Z-Di
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:01:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evO1L-00013m-9F
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C26B98011454
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 14:01:46 +0000 (UTC)
References: <20180312124939.20562-1-berrange@redhat.com>
	<c9bbe182-4a13-0063-4ce8-98151f1bd228@redhat.com>
	<20180312131445.GS3493@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d9b8ddd-ccef-f486-6195-b1a17ea1991a@redhat.com>
Date: Mon, 12 Mar 2018 09:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180312131445.GS3493@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Enable passing pre-opened chardev
 socket FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 03/12/2018 08:14 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 12, 2018 at 08:12:44AM -0500, Eric Blake wrote:
>> On 03/12/2018 07:49 AM, Daniel P. Berrang=C3=A9 wrote:
>>> An update of:
>>>
>>>     v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg0461=
8.html
>>>     v2: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg0470=
6.html
>>>     v3: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg0489=
2.html
>>>     v4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg0095=
0.html
>>>
>>> This enables fixing a long standing problem that libvirt has with
>>> starting up QEMU. It has to busy-wait retrying connect() on the QMP
>>> monitor socket until QEMU finally creates & listens on it, but at sam=
e
>>> time must be careful to not wait forever if QEMU exits.
>>>
>>> With this patch series, libvirt can simply pass in a pre-opened UNIX =
domain
>>> socket file descriptor, which it can immediately connect to with no b=
usy-wait.
>>>

>> Whose tree should this go through?  It's got some QAPI impact, so I'm =
okay
>> including it in my QAPI pull request later today, if there is no bette=
r
>> tree...
>=20
> These days I usually send PR for stuff touching sockets code myself. So
> unless someone else strongly prefers to take it via their tree for sake
> of any easy of conflict / merge resolution, I can do a PR once acked.

Okay, I'll go through one more round of reviews, then let you send the=20
PR; we still have time to make softfreeze tomorrow.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
