Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2084C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1862214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XobVNXde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1862214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07AC-00086p-Tx
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j079I-0007KN-Pc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j079H-0006Ah-87
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:10:36 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j079H-0006AO-1g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:10:35 -0500
Received: by mail-ot1-x341.google.com with SMTP id j20so2848458otq.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aQexNwjtTPORkoeMe0qjZ/4WcoZeRMZqyihVIjfZTXo=;
 b=XobVNXdewi4uRC9P0en8AwjaeCxGwtHuRETt2IC2qt2u/l11yKf/BpfswOeu7TpIAW
 ADpO1xBdrB9+CXfBE+VYSBdc7DOa7JIefcczXSHjd5oBWThZykLyl1umUDAtzA86c/t8
 KpZMTPTa31dcj/87ZXq6WSQfbKZESECCdnFZQVnEPDl8esuenKlESBBmqkPsY/zZ12ih
 33ypfiTV5ddRuBsGbRmmAFfTiGwjxMsaMFTKzlE0Nz/qGn7BFCUkfg+b1EFG5sHp+4CD
 qV+p9c5m9P0WvMNg1CxoUqsc4YGUhosRcfujw8yVBpSaiGrYwUFChukNPSCTeM2qSaF1
 kB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aQexNwjtTPORkoeMe0qjZ/4WcoZeRMZqyihVIjfZTXo=;
 b=C52eR6eEfhxn6zPu/Q0pHPUkeooMb1fSTU9eBfSPjkDuxs6ICig8VOMAbHf6UmtGoN
 vQd3JNO67SsgZPNAEdR9fK6xiIYoeA85HqFxn1BqFSx+cWGnQs95bYCsAAtc46RsRYvW
 Pmxd10HYZog6HgdxUU7n6UUyVZxjI5M3bLJzm9U1J2k7INuFlfkWWrM9fsdgH7mqS6Nq
 RsvVll6BphG3/tGlV7HdliHQ/MNrjDoVibJ5QPCWrd7050LQqzy0SPbWIVrBo27aZhxK
 Qhmhfu7Xri3IktMlNQwADA0u3ItTNFwxzMBjbalL29oCzxDCwEu7EXuvymNMrWZVNDC6
 v35A==
X-Gm-Message-State: APjAAAWfgKmXwpMJFQylyEnLTCwoiaIo1FMHlN4A2s26EohhR+beUyBd
 w8xeCeV1jf9r45VOdoSHlJs8DpQTBAhga/5RKR7uvg==
X-Google-Smtp-Source: APXvYqxUC3BQ0rHp6uJcwETkQwJA0BU+d83EPa9HHHzF5irVf7wEEF7IiccbEy82sMXv/FkIURiNvGSkvr+qP6EKTPM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr298739ota.232.1581095434030; 
 Fri, 07 Feb 2020 09:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <877e0ynxhx.fsf@dusky.pond.sub.org>
In-Reply-To: <877e0ynxhx.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:10:23 +0000
Message-ID: <CAFEAcA-owBQMnvY5Asa4m4DUF-hBqRTmu8C7fktfvMRE2HZfgg@mail.gmail.com>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 17:00, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > This series switches all our QAPI doc comments over from
> > texinfo format to rST.
> >
> > The basic approach is somewhat similar to how we deal with kerneldoc
> > and hxtool: we have a custom Sphinx extension which is passed a
> > filename which is the json file it should run the QAPI parser over and
> > generate documentation for. Unlike 'kerneldoc' but somewhat like
> > hxtool, I have chosed to generate documentation by generating a tree
> > of docutils nodes, rather than by generating rST source that is then
> > fed to the rST parser to generate docutils nodes.  Individual lumps of
> > doc comment go to the rST parser, but the structured parts we render
> > directly. This makes it easier to get the structure and heading level
> > nesting correct.
> >
> > Rather than trying to exactly handle all the existing comments I have
> > opted (as Markus suggested) to tweak them where this seemed more
> > sensible than contorting the rST generator to deal with
> > weirdnesses. The principal changes are:
> >  * whitespace is now significant, and multiline definitions must have
> >    their second and subsequent lines indented to match the first line
> >  * general rST format markup is permitted, not just the small set of
> >    markup the old texinfo generator handled. For most things (notably
> >    bulleted and itemized lists) the old format is the same as rST was.
> >  * Specific things that might trip people up:
> >    - instead of *bold* and _italic_ rST has **bold** and *italic*
>
> Actually, qapi-code-gen.txt documents and doc.py implements *strong* and
> _emphasis_.  Texinfo commonly renders them as bold and italic when the
> output format supports that.  rST has **strong** and *emphasis*.
>
> Your series adjusts emphasis markup for rST [PATCH 18].  Since it
> doesn't touch strong markup, strong silently becomes emphasis.  I guess
> that's okay, perhaps even an improvement, but double-checking the actual
> uses of this markup wouldn't hurt.

Yeah, that would be a good plan.
 git grep '\*[^*]*\*' qapi/*.json
(and eyeball-filtering out the false hits) shows just one use:

qapi/introspect.json:# Note: the QAPI schema is also used to help
define *internal*

I can put a patch on the end which converts that to **internal**
once the rST generator is in use.

> >    - lists need a preceding and following blank line
> >    - a lone literal '*' will need to be backslash-escaped to
> >      avoid a rST syntax error
> >  * the old leading '|' for example (literal text) blocks is replaced
> >    by the standard rST '::' literal block.
> >  * headings and subheadings must now be in a freeform documentation
> >    comment of their own
>
> Can we simply use rST instead?  See my review of PATCH 18.

No, we can't (see my reply to that review). In theory you could have
the heading syntax be a rST heading, but that is not feasible to
recognise in the Python script[*] and it gives the impression that
it is just an inline rST heading, not something that's more complicated
and structured.

[*] You'd need to manually re-implement the weird thing rST does
where practically any kind of underlining is valid and it figures
out which one means which depth by looking at the usage through
the whole document. You'd have to do bizarre stuff like running
through the entire set of doc comments once doing no output but
just looking at heading underline characters to guess which one
is which depth, and then once you'd figured that out you could
do it all over again actually generating the doc.

thanks
-- PMM

