Received: from eggs.gnu.org ([2001:4830:134:3::10]:53665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI9u4-00076n-8y
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI9u3-00032d-A1
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:36:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fI9u3-00032L-3l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:36:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id k17-v6so10079038oih.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 02:36:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514093320.GI29495@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180511224823.GR13350@localhost.localdomain>
	<20180514093320.GI29495@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 10:36:01 +0100
Message-ID: <CAFEAcA9Oy81A5Q1fSqshPb7xY79Cbm5oF0-28La=OA6Z_foRSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Requiring Python 2.7+ (was Re: [PATCH 0/3]
 Document intent for supported build platforms and bump min glib to 2.42)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Olaf Hering <olaf@aepfle.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 14 May 2018 at 10:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
> On Fri, May 11, 2018 at 07:48:23PM -0300, Eduardo Habkost wrote:
>> On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> [...]
>> > Based on that doc and https://repology.org/metapackage/glib/versions,
>> > I identified that we could feasibly set min glib to 2.42. Note that
>> > this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
>> > 2010 so that's reasonable to drop IMHO). It would still cover 2 major
>> > Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
>> > 14.04). This min glib lets us remove almost all our compat code.
>>
>> If we're dropping RHEL-6, is there anything else blocking us from
>> bumping the minimum required Python versino to 2.7?
>>
>> From the wording on patch 1/3, it looks like we will drop support
>> for SLES-11 too?
>
> Yes, that is correct.
>
> py27 seems reasonable to me, assuming none of Peter's build machines
> are stuck on 2.6

OSX was the most likely candidate for that, and it's 2.7.

thanks
-- PMM
