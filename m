Received: from eggs.gnu.org ([2001:4830:134:3::10]:60396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYYxI-0001w7-79
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYYxE-0000DP-Pq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYYxE-0000C6-G5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-3-marcandre.lureau@redhat.com>
	<CAMxuvaxByOCS4FfPYfec2yxpz78voztXGS99kw3p-ptO5-hz5A@mail.gmail.com>
Date: Thu, 28 Jun 2018 17:35:21 +0200
In-Reply-To: <CAMxuvaxByOCS4FfPYfec2yxpz78voztXGS99kw3p-ptO5-hz5A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:39:52 +0200")
Message-ID: <87lgaygc06.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/15] tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Armbruster,
	Markus" <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> doh.. this had to be squashed with previous patch!

Happy to do that when I apply.

> On Wed, Jun 27, 2018 at 6:35 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> ---
>>  tests/test-qmp-cmds.c                   | 8 +++++++-
>>  tests/qapi-schema/qapi-schema-test.json | 6 ++++++
>>  tests/qapi-schema/qapi-schema-test.out  | 6 +++++-
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
>> index eaf30b7a0f..840530b84c 100644
>> --- a/tests/test-qmp-cmds.c
>> +++ b/tests/test-qmp-cmds.c
>> @@ -13,11 +13,17 @@
>>  static QmpCommandList qmp_commands;
>>
>>  /* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
>> -void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
>> +UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
>>  {
>> +    return NULL;
>>  }
>>  /* #endif */
>>
>> +UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
>> +{
>> +    return NULL;
>> +}
>> +
>>  void qmp_user_def_cmd(Error **errp)
>>  {
>>  }
>> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema=
/qapi-schema-test.json
>> index ec0fea804f..16209b57b3 100644
>> --- a/tests/qapi-schema/qapi-schema-test.json
>> +++ b/tests/qapi-schema/qapi-schema-test.json
>> @@ -56,6 +56,9 @@
>>    'data': { 'string0': 'str',
>>              'dict1': 'UserDefTwoDict' } }
>>
>> +{ 'struct': 'UserDefThree',
>> +  'data': { 'string0': 'str' } }
>> +
>>  # dummy struct to force generation of array types not otherwise mention=
ed
>>  { 'struct': 'ForceArrays',
>>    'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
>> @@ -209,7 +212,10 @@
>>    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
>>
>>  { 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
>> +  'returns': 'UserDefThree',
>>    'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
>>
>> +{ 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
>> +
>>  { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
>>    'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
>> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/=
qapi-schema-test.out
>> index 34b6d546f3..ed25e5b60c 100644
>> --- a/tests/qapi-schema/qapi-schema-test.out
>> +++ b/tests/qapi-schema/qapi-schema-test.out
>> @@ -36,6 +36,8 @@ object UserDefTwoDict
>>  object UserDefTwo
>>      member string0: str optional=3DFalse
>>      member dict1: UserDefTwoDict optional=3DFalse
>> +object UserDefThree
>> +    member string0: str optional=3DFalse
>>  object ForceArrays
>>      member unused1: UserDefOneList optional=3DFalse
>>      member unused2: UserDefTwoList optional=3DFalse
>> @@ -249,7 +251,9 @@ alternate TestIfAlternate
>>      case bar: TestStruct
>>  object q_obj_TestIfCmd-arg
>>      member foo: TestIfStruct optional=3DFalse
>> -command TestIfCmd q_obj_TestIfCmd-arg -> None
>> +command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
>> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
>> +command TestCmdReturnDefThree None -> UserDefThree
>>     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
>>  object q_obj_TestIfEvent-arg
>>      member foo: TestIfStruct optional=3DFalse
>> --
>> 2.18.0.rc1
>>

This provides the test coverage I asked for in review of v5's PATCH 11.
Thanks!
