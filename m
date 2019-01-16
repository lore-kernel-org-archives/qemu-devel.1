Received: from eggs.gnu.org ([209.51.188.92]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjfZ-0005qC-NE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjfY-00014J-Kr
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:47:41 -0500
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
	<7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
Date: Wed, 16 Jan 2019 12:47:36 +0100
MIME-Version: 1.0
In-Reply-To: <7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ppc: Fix duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 2019-01-16 12:43, C=C3=A9dric Le Goater wrote:
> On 1/11/19 9:17 AM, Thomas Huth wrote:
>> When compiling the ppc code with clang and -std=3Dgnu99, there are a
>> couple of warnings/errors like this one:
>>
>>   CC      ppc64-softmmu/hw/intc/xics.o
>> In file included from hw/intc/xics.c:35:
>> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState'=
 is a C11 feature
>>       [-Werror,-Wtypedef-redefinition]
>> typedef struct ICPState ICPState;
>>                         ^
>> target/ppc/cpu.h:1181:25: note: previous definition is here
>> typedef struct ICPState ICPState;
>>                         ^
>> Work around the problems by including the proper headers instead.
>=20
> Thomas,
>=20
>=20
> After a closer look, I think we should use 'void *' under PowerPCCPU=20
> as it was the case before I introduced the second interrupt presenter.

If you don't like the #includes, why not simply do anonymous struct
forward declarations here? I think that would be better than "void *".

> That's a bigger change reverting bits of already merged patches. I can
> take care of it if you prefer.=20

Could I keep the current patch in my series so that I can get the
patches finally merged? You could then do any clean up that you like on
top of it, ok?

> I use a f29 for dev. Which compiler should I install ?=20

Any version of Clang with -std=3Dgnu99 should do the job here, I think.

 Thomas
