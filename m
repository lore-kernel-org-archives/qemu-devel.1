Received: from eggs.gnu.org ([2001:4830:134:3::10]:39681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX9mb-0000hP-Gk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX9mY-0006pW-Pf
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX9mY-0006oy-Hd
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:02:54 -0500
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
	<afe4f7e1-bc43-b384-a05d-678c78f65f3a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ba9266b-cc1c-e623-4ab1-b0a658e98e2b@redhat.com>
Date: Wed, 12 Dec 2018 20:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <afe4f7e1-bc43-b384-a05d-678c78f65f3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/54] Misc patches for 2018-12-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 2018-12-12 17:16, Eric Blake wrote:
> On 12/12/18 9:22 AM, Paolo Bonzini wrote:
>> The following changes since commit
>> bb9bf94b3e8926553290bc9a7cb84315af422086:
>>
>> =C2=A0=C2=A0 Merge remote-tracking branch
>> 'remotes/ehabkost/tags/machine-next-pull-request' into staging
>> (2018-12-11 19:18:58 +0000)
>>
>> are available in the git repository at:
>>
>>
>> =C2=A0=C2=A0 git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to e2a9129b491fdb3be3661baf08a9fa4c2e19a02=
8:
>>
>> =C2=A0=C2=A0 vhost-user-test: create a temporary directory per TestSer=
ver
>> (2018-12-12 13:49:31 +0100)
>>
>> This introduces a new dependency on perl's Test::Harness package.=C2=A0
>> This is
>> distributed in package perl-Test-Harness for Fedora, and
>> libtest-harness-perl
>> for Debian.=C2=A0 I couldn't find anything for BSD or macOS, but at le=
ast the
>> Patchew BSD images already have it so it is probably bundled with Perl=
.
>=20
>> * add explicit checks for the compiler version and cleanup (Thomas)
>=20
> Thomas sent a separate pull request for these. Git will probably do the
> right thing if the two pull requests have identical commits, but I
> didn't check if there were any minor variations in patch contents that
> would cause a conflict.

There's likely a conflict in the "-fno-gcse" patch since this has minor
edits ... Sorry for that.

So Peter, you've got two options now:

1) Apply Paolo's series. I'll then send a revert for patch 24/54 later.

2) Apply my series first. In that case, I think Paolo should send a v2
of his PULL request with patch 24 and 33-39 dropped.

 Thomas
