Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTSM-0005ao-Jm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTSF-0005rb-VQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTSF-0005nK-Kw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:00:35 -0400
References: <20180823102502.28122-1-berrange@redhat.com>
	<20181019112250.GA19474@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6c6768c-dbc1-e1be-fe94-3a354fa0cad0@redhat.com>
Date: Fri, 19 Oct 2018 14:00:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181019112250.GA19474@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 19/10/2018 13:22, Daniel P. Berrang=C3=A9 wrote:
> Copying Paolo, since this probably falls under the "misc patches"
> maintainer bucket.

I think we should define a "generic maintainer stuff" bucket where every
maintainer is supposed to send patches with a Reviewed-by.  Maintainers
are probably good enough at getting reviews by an appropriate person.

(I am slowly trying to remove stuff from the misc bucket).

Paolo

> On Thu, Aug 23, 2018 at 11:25:02AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> In some cases the Author: email address in patches submitted to the
>> list gets mangled such that it says
>>
>>     John Doe via Qemu-devel <qemu-devel@nongnu.org>
>>
>> This change is a result of workarounds for DMARC policies.
>>
>> Subsystem maintainers accepting patches need to catch these and fix
>> them before sending pull requests, so a checkpatch.pl test is highly
>> desirable.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 42e1c50dd8..be2114a179 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1402,6 +1402,10 @@ sub process {
>>  			$is_patch =3D 1;
>>  		}
>> =20
>> +		if ($line =3D~ /^Author: .*via Qemu-devel.*<qemu-devel\@nongnu.org>=
/) {
>> +		    ERROR("Author email address is mangled by the mailing list\n" .=
 $herecurr);
>> +		}
>> +
>>  #check the patch for a signoff:
>>  		if ($line =3D~ /^\s*signed-off-by:/i) {
>>  			# This is a signoff, if ugly, so do not double report.
>> --=20
>> 2.17.1
>>
>=20
> Regards,
> Daniel
>=20
