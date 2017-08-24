Received: from eggs.gnu.org ([2001:4830:134:3::10]:40964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwyy-0000rx-FE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwyu-00049K-HK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkwyu-000490-BO
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CKu0ewTNa2n3hY5h-n756xRDZUk4gy8y0eAGiOjVH29dQ@mail.gmail.com>
Date: Thu, 24 Aug 2017 20:35:49 +0200
In-Reply-To: <CAJ+F1CKu0ewTNa2n3hY5h-n756xRDZUk4gy8y0eAGiOjVH29dQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 24 Aug 2017
	12:50:40 +0200")
Message-ID: <87tw0wdda2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/16] tpm: Clean up model registration &
 lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@us.ibm.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Aug 24, 2017 at 10:45 AM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> We have a strict separation between enum TpmModel and tpm_models[]:
>>
>> * TpmModel may have any number of members.  It just happens to have one.
>>
>> * tpm_register_model() uses the first empty slot in tmp_models[].
>>
>>   If you register more than tpm_models[] has space,
>>   tpn_register_model() fails.  Its caller silently ignores the
>>   failure.
>
> tpm_

Will fix.

>>
>>   Register the same TpmModel more than once has no effect other than
>>   wasting tpm_models[] slots: tpm_model_is_registered() is happy with
>>   the first one it finds.
>>
>> Since we only ever register one model, and tpm_models[] has space for
>> just that one, this contraption even works.
>>
>> Turn tpm_models[] into a straight map from enum TpmType to bool.  Much
>> simpler.
>>
>> Cc: Stefan Berger <stefanb@us.ibm.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

[...]
