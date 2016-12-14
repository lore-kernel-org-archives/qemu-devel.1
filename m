Received: from eggs.gnu.org ([2001:4830:134:3::10]:48815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHCPi-0004Kt-K5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHCPe-00020q-N1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:28:18 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHCPe-00020I-JL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:28:14 -0500
Received: by mail-io0-f173.google.com with SMTP id d9so44656648ioe.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 08:28:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1619747.imectsegtr@thyrus.usersys.redhat.com>
References: <20161214144713.11009-1-stefanha@redhat.com>
	<1619747.imectsegtr@thyrus.usersys.redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 16:27:13 +0000
Message-ID: <CAJSP0QUxXanfGD1H=j+cNs_P_1T4w6xmrmRrjBE8rx6aEaOmDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pino Toscano <ptoscano@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Wed, Dec 14, 2016 at 3:40 PM, Pino Toscano <ptoscano@redhat.com> wrote:
> On Wednesday, 14 December 2016 14:47:13 CET Stefan Hajnoczi wrote:
>> There are missing translations for the new "Copy" menu item.
>>
>> The following people provided them to me on IRC just in time for the
>> QEMU 2.8 release:
>>
>>  * de_DE - Stefan Hajnoczi <stefanha@redhat.com>
>>  * fr_FR - Laurent Vivier <laurent@vivier.eu>
>>  * it    - Pino Toscano <ptoscano@redhat.com>
>>  * zh_CN - Fam Zheng <famz@redhat.com>
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Pino Toscano <ptoscano@redhat.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> [...]
>> diff --git a/po/it.po b/po/it.po
>> index 8eadf2f..bfae84e 100644
>> --- a/po/it.po
>> +++ b/po/it.po
>> @@ -42,11 +42,11 @@ msgstr "_Esci"
>>
>>  #: ui/gtk.c:2029
>>  msgid "_Fullscreen"
>> -msgstr ""
>> +msgstr "A t_utto schermo"
>>
>>  #: ui/gtk.c:2032
>>  msgid "_Copy"
>> -msgstr ""
>> +msgstr "_Copia"
>>
>>  #: ui/gtk.c:2048
>>  msgid "Zoom _In"
>
> ACK.
>
> Should PO-Revision-Date be updated as well?

No, I will ignore the po metadata as some of the previous commits have done.

I've looked through the commit history: sometimes we update them,
sometimes we don't.  The creation date field keeps getting changed
although the revision date doesn't (i.e. creation is newer than
revision date!).  The QEMU version in the Project-Id is ridiculously
out of date.  These fields may make sense in some translation
workflows, especially without a version control system, but for the
QEMU project they are useless.

If allowed by the file format we should remove them completely since
git already contains this information.

Stefan
