Received: from eggs.gnu.org ([2001:4830:134:3::10]:47158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cZ4SR-0000QB-KJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cZ4SN-0006NA-F8
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:36:59 -0500
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:37694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cZ4SN-0006Mm-9g
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:36:55 -0500
Received: by mail-it0-x235.google.com with SMTP id r185so29768299ita.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 15:36:55 -0800 (PST)
In-Reply-To: <97ae663a-f2d1-c45d-bb8d-8be352d8f84c@redhat.com>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<58763C1D-20EB-4C1F-86EC-C9903F87BDB3@gmail.com>
	<97ae663a-f2d1-c45d-bb8d-8be352d8f84c@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87B90AC4-A4F9-4A6B-83F9-4E351BC71F80@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 1 Feb 2017 18:36:49 -0500
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Feb 1, 2017, at 6:17 PM, Paolo Bonzini wrote:

>
>
> On 01/02/2017 14:50, G 3 wrote:
>> I was thinking maybe we should add Rich Text Format, or maybe even a
>> word processing format like OpenOffice, or Microsoft Word to the  
>> list of
>> possible formats. These formats are super easy to use. No formatting
>> rules to have to learn. All the user needs to do is just type up  
>> their
>> contribute to the documentation in a word processor. The word  
>> processor
>> would do all the formatting work. Tables, links, stylized text are  
>> all
>> possible. This would allow us to export to other formats like  
>> HTML, PDF,
>> and ascii text.
>
> That's exactly what we _don't_ want.
>
> We need documentation to be consistent.  RTF, OpenOffice, etc. are
> presentation-based format (or at least 99% users use them as such),  
> and
> this automatically disqualifies them.  We don't want our documentation
> to be a mixture of Arial, Times New Roman and Comic Sans depending on
> the user that's contributing.  Besides, conversion of word processor
> documents to HTML usually looks terrible.
>
> The requirements for the format are:
>
> * support for HTML and man as output formats, optionally PDF and text
> * support for QEMU's usual submission workflow
> * producing documentation with a consistent look
> * tool support and extensibility
> * being easy to use and not too obscure
>
> in this order.  Based on this, the only formats we could plausibly use
> are Texinfo (if only because that's what we use now), Markdown,
> restructuredText, Docbook and Asciidoc.  The poll mentioned all of  
> these
> except Asciidoc, plus LaTeX as a "control group".
>
> Paolo

Ok. I understand.

For the above requirements of "tool support and extensibility", what  
do you mean by this? Do you mean command-line tool support? What do  
you mean by extensibility?
