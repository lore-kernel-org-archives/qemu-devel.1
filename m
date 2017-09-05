Received: from eggs.gnu.org ([2001:4830:134:3::10]:51487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8PR-00017w-6b
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8PM-0006At-Eo
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp8PM-0006Af-5r
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:36:28 -0400
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
	<d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
	<CAFEAcA8-pX+QoqSwNzL9vvRqwByoazOzB2970a2K5Zg8CXKL+A@mail.gmail.com>
	<87vakx399z.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6c65736-a095-e546-7798-d9028321f579@redhat.com>
Date: Tue, 5 Sep 2017 09:36:23 +0200
MIME-Version: 1.0
In-Reply-To: <87vakx399z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 05.09.2017 09:16, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On 4 September 2017 at 19:09, Thomas Huth <thuth@redhat.com> wrote:
>>> On 04.09.2017 19:19, Peter Maydell wrote:
>>>> Nobody has mentioned AIX host support on the mailing list for years,
>>>> and we have no test systems for it so it is most likely broken.
>>>> We've advertised in configure for two releases now that we plan
>>>> to drop support for this host OS, and have had no complaints.
>>>
>>> We just added this some weeks ago to our qemu-doc.texi:
>>>
>>> "Prior to the 2.10.0 release there was no official policy on how long
>>> features would be deprecated prior to their removal, nor any document=
ed
>>> list of which features were deprecated. Thus any features deprecated
>>> prior to 2.10.0 will be treated as if they were first deprecated in t=
he
>>> 2.10.0 release."
>=20
> Daniel's commit eb22aeca65f.
>=20
>> We pretty clearly say in the configure message
>>     echo "The QEMU project intends to remove support for this host OS =
in"
>>     echo "a future release if nobody volunteers to maintain it and to"
>>     echo "provide a build host for our continuous integration setup."
>>
>> and my intention when I wrote that was absolutely to dump old
>> OSes in a couple of releases... The amount of code removed here
>> isn't great so I guess waiting a little longer doesn't hurt,
>> but I feel like somebody's moved the goalposts in adding that
>> language and not listing the deprecated host OSes and CPUs
>> in the list of deprecated features in 2.10 :-(
>=20
> AIX host has been *clearly* deprecated since 2.9.0 (commit 898be3e).
> Failure to include that in a summary added later and elsewhere does not
> undo that.
Yes, sure, I fully agree that it is marked as deprecated since 2.9. I
certainly did *not* want to say that grace period for the AIX removal
has now to start with QEMU 2.11 - sorry if my mail was not clear in that
way. I just wanted to discuss whether we should apply the "any features
deprecated prior to 2.10.0 will be treated as if they were first
deprecated in the 2.10.0 release" idea here, too.

OTOH, AIX support is really very, very like broken since years and
nobody complained (since there haven't been any AIX-related bug fix
commits in years), so I guess nobody will complain if we remove it right
now already.

 Thomas
