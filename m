Received: from eggs.gnu.org ([2001:4830:134:3::10]:55760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgTu-0004xk-8x
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgTt-00054F-C6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:24:30 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVgTt-00054A-5l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:24:29 -0500
Received: by mail-ua0-x22c.google.com with SMTP id 35so112134677uak.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 07:24:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
References: <20170123142629.11110-1-berrange@redhat.com>
	<CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 15:24:08 +0000
Message-ID: <CAFEAcA9mrojabfsFfkw+Yb0jRUyB0gs6+SHeLu4sDku1gmfrRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 14:46, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 23 January 2017 at 14:26, Daniel P. Berrange <berrange@redhat.com> wro=
te:
>> The following changes since commit 598cf1c805271564686f2d732b36f50c3c40d=
cdd:
>>
>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into =
staging (2017-01-20 16:42:07 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/berrange/qemu tags/pull-qio-2017-01-23-1
>>
>> for you to fetch changes up to 19f3cc22d364b57315e171090ee2e499b58775b4:
>>
>>   io: introduce a DNS resolver API (2017-01-23 11:28:09 +0000)
>>
>> ----------------------------------------------------------------
>> Merge io/ 2017-01-23
>>
>> Daniel P. Berrange (8):
>>   sockets: add ability to disable DNS resolution for InetSocketAddress
>>   io: stop incrementing reference in qio_task_get_source
>>   io: fix typo in docs for QIOTask
>>   io: add ability to associate an opaque "result" with with a task
>>   io: add ability to associate an error with a task
>>   io: change the QIOTask callback signature
>>   io: remove Error parameter from QIOTask thread worker
>>   io: introduce a DNS resolver API
>
> Fails to build, OSX:

Also w32:
/home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c: In function
=E2=80=98inet_listen_saddr=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c:145:41:
error: =E2=80=98AI_NUMERICSERV=E2=80=99 undeclared (first use in this funct=
ion)
         ai.ai_flags |=3D AI_NUMERICHOST | AI_NUMERICSERV;
                                         ^
/home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c:145:41:
note: each undeclared identifier is reported only once for each
function it appears in


thanks
-- PMM
