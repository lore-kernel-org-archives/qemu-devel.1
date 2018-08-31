Received: from eggs.gnu.org ([2001:4830:134:3::10]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvjJk-0005zk-6F
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvjJf-0001N4-OY
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:18:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvjJf-0001Mw-J5
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:18:23 -0400
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
	<1535704738-8986-9-git-send-email-thuth@redhat.com>
	<87efeerbcu.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <593af39a-cc9b-d4e8-7e6c-efdbbe169096@redhat.com>
Date: Fri, 31 Aug 2018 15:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <87efeerbcu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 8/9] tests: add qmp/qom-set-without-value
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2018-08-31 14:04, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> test_qom_set_without_value() is about a bug in infrastructure used by
>> the QMP core, fixed in commit c489780203.  We covered the bug in
>> infrastructure unit tests (commit bce3035a44).  I wrote that test
>> earlier, to cover QMP level as well, the test could go into qmp-test.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qmp-test.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index b347228..2b923f0 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -321,6 +321,19 @@ static void test_qmp_preconfig(void)
>>      qtest_quit(qs);
>>  }
>> =20
>> +static void test_qom_set_without_value(void)
>> +{
>> +    QTestState *qts;
>> +    QDict *resp;
>> +
>> +    qts =3D qtest_init(common_args);
>> +    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
>> +                     " { 'path': '/machine', 'property': 'rtc-time' }=
 }");
>> +    g_assert_nonnull(resp);
>> +    qmp_assert_error_class(resp, "GenericError");
>> +    qtest_quit(qts);
>> +}
>> +
>>  int main(int argc, char *argv[])
>>  {
>>      g_test_init(&argc, &argv, NULL);
>> @@ -328,6 +341,7 @@ int main(int argc, char *argv[])
>>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>>      qtest_add_func("qmp/oob", test_qmp_oob);
>>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_=
value);
>> =20
>>      return g_test_run();
>>  }
>=20
> I'm afraid you missed my objection to naming:
> Message-ID: <8736uvujxx.fsf@dusky.pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg06368.html

Sorry about that, I was not on CC: for that series. I used the patches
from v5 where Marc-Andr=C3=A9 put me on CC:.

> If you could work that into PULL v2, I'd be obliged.  If not, I'll have
> to address it in a follow-up patch.

IMHO the naming is not that bad ... OTOH, I think Peter might already be
away? ... so we've got plenty of time to sort this out anyway.
Marc-Andr=C3=A9, could you send a new version of the patch?

 Thomas
