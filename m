Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 20:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE51420723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 20:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTKiJYlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE51420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcEYB-0003vh-Vp
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 16:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcEXF-0002sA-Tf
 for qemu-devel@nongnu.org; Fri, 22 May 2020 16:44:53 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcEXE-00078L-IH
 for qemu-devel@nongnu.org; Fri, 22 May 2020 16:44:53 -0400
Received: by mail-lj1-x242.google.com with SMTP id v16so14283031ljc.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LhiTtjgYd68iklkd2Tu469UiUxRPDvQtVuow9rEM/fc=;
 b=KTKiJYlUc2EvI/eaUOlZTNpco3jN+/0UIhibmU9HIsfM9yRXRS+wbfl2IwignBNhmE
 Jafh+6YTXft++t/YzbFxaeC4oeSjbCu2RaMmEVt6mVstHQF5awddChDewD0p/yi36u06
 aP7+S/oIoEzWHMbe2mDIUVrRfD8bBxWfsEvEUVQGGY2UDuxcIDdY3uKBj0RtXE2rTZtw
 ZxvBE7SwV3lVtGBsBi8tFNB2nTpEh8Dh5wfOVEFELyOA3lKfLULDtEL9iYSxNpRySLbO
 oNJoyJXaF15SVE4mXQQMO0HZQgAsIEf5RJDO0cQaacDXZPComlKM5WM1UxEuroXtsO4B
 LNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LhiTtjgYd68iklkd2Tu469UiUxRPDvQtVuow9rEM/fc=;
 b=YzLA4NZvOvAe9CqExS2wQC6aDDAu8jqMazolEMclrA1R4VwzPTQhNAvh2MtTxK7Zi3
 zaO2NYXxAeaZ21SGLWa5i7ob2s9qC0RbYr0gREQRBXXhsTVgQCXJVUz4mA2QLbw0H9FO
 BxGJIQs3KLBvjlZJ3cysFdrzyO4skIESXZfoR6eNbXoyzTPeMbBs+hVToaoprfpzg6AJ
 Tg0GFcyLjWvfqjgBxHBltPsjtw/dOmSm9OKyah0f7jneZuH/h3fGLjLsOf/swsmQmeFK
 oL7nQodpRdLNtIndIr43fIBVJkrGAFfU9r8XLP67hxJC8WPVQPl232e/E1aLfwn2tlut
 Jhgw==
X-Gm-Message-State: AOAM530gAR6kInpMlwNGOISQ13zLNMX3uDLCzt0h/38EMCbaWzL0j/09
 eR+zmaA/BhNxlWqdUdT3Tb/mxa469UBcQeR0+SuuGg==
X-Google-Smtp-Source: ABdhPJx3ge2YKJmCAGgEB8czBmczJH8VMjnSMMh2ZdI6aBCUoiIHHyNQTv5S9DUqMcRW1FXbV+VZgOD0mqWGUbAzkzg=
X-Received: by 2002:a2e:3c0b:: with SMTP id j11mr6637042lja.424.1590180290332; 
 Fri, 22 May 2020 13:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-13-robert.foley@linaro.org>
 <87zha0c4nw.fsf@linaro.org>
In-Reply-To: <87zha0c4nw.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 16:44:43 -0400
Message-ID: <CAEyhzFt=bwj_-TU2Mj3ts6HwfTaC0Rj8e6UoOJcFCjPqHU9LqQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] tests/vm: Add workaround to consume console
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 12:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> I think you need to look at adding:
>
> [sendemail]
>         cccmd =3D scripts/get_maintainer.pl --nogit-fallback
>
> to your .git/config to ensure maintainers get pinged when you touch
> their subsystems. Eduardo and Cleber CC'd


Thanks for pointing this out!  We will definitely add it and use it.

> > The ConsoleSocket object provides a socket interface
> > which will consume all arriving characters on the
> > socket, but will provide those chars via recv() as
> > would a regular socket.
> > This is a workaround we found was needed since
> > there is a known issue where QEMU will hang waiting
> > for console characters to be consumed.
> > We also add the option of logging the console to a file.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > ---
> >  python/qemu/console_socket.py | 162 ++++++++++++++++++++++++++++++++++
> >  python/qemu/machine.py        |  23 ++++-
> >  tests/vm/Makefile.include     |   4 +
> >  tests/vm/basevm.py            |  19 +++-
> >  4 files changed, 202 insertions(+), 6 deletions(-)
> >  create mode 100644 python/qemu/console_socket.py
> >
> > diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket=
.py
<snip>
> > +import traceback
>
> Left over debug?

This is getting used here in a try except in handle_read, to display
the exception information.

<snip>
> > +    def handle_read(self):
> > +        """process arriving characters into in memory _buffer"""
> > +        try:
> > +            data =3D asyncore.dispatcher.recv(self, 1)
> > +            # latin1 is needed since there are some chars
> > +            # we are receiving that cannot be encoded to utf-8
> > +            # such as 0xe2, 0x80, 0xA6.
> > +            string =3D data.decode("latin1")
> > +        except:
> > +            print("Exception seen.")
> > +            traceback.print_exc()
> > +            return
> > +        if self._logfile:
> > +            self._logfile.write("{}".format(string))
> > +            self._logfile.flush()
> > +        for c in string:
> > +            self._buffer.append(c)
<snip>
> > +if __name__ =3D=3D '__main__':
>
> If the module is meant to be executable then you need to +x the file.
> However since 8f8fd9edba I think everything is meant to be doing things
> the pythonic way as a proper module. I'm not sure where unit tests for
> the modules are meant to sit in this case.

That is a good point.  I see the other modules at this level do not have
tests like this, so I am going to remove this for now, as I think it adds
limited value at this point.
>
> > +    # Brief test to exercise the above code.
> > +    # The ConsoleSocket will ship some data to the server,
> > +    # the server will echo it back and the client will echo what it re=
ceived.
> > +
> > +    # First remove the socket.
> > +    address =3D "./test_console_socket"
> > +    if os.path.exists(address):
> > +        os.unlink(address)
> > +
> > +    # Create the server side.
> > +    server_socket =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM=
)
> > +    server_socket.bind(address)
> > +    server_socket.listen(1)
> > +
> > +    # Create the object we are trying to test.
> > +    console_socket =3D ConsoleSocket(address, file=3D"./logfile.txt")
> > +
> > +    # Generate some data and ship it over the socket.
> > +    send_data =3D ""
> > +    for i in range(10):
> > +        send_data +=3D "this is a test message {}\n".format(i)
> > +    console_socket.send(send_data.encode('latin1'))
> > +    connection, client_address =3D server_socket.accept()
> > +
> > +    # Process the data on the server and ship it back.
> > +    data =3D connection.recv(len(send_data))
> > +    print("server received: {}".format(data))
> > +    print("server: sending data back to the client")
> > +    connection.sendall(data)
> > +
> > +    # Client receives teh bytes and displays them.
>
> s/teh/the/
>
> > +    print("client: receiving bytes")
> > +    bytes =3D console_socket.recv(len(data))
> > +    recv_data =3D bytes.decode('latin1')
> > +    print("client received: {}".format(recv_data))
> > +    assert(recv_data =3D=3D send_data)
> > +    # Close console connection first, then close server.
> > +    console_socket.close()
> > +    connection.close()
> > +    server_socket.close()
> > +    print("test successful.")
> > +
>
> I think in this case it might be worth splitting introducing the
> functionally into the python library from the actual usage of it in the
> wider machines.

OK, I'll split this out into a separate patch.

Thanks & Regards,
-Rob
>
> Otherwise it seems to work well enough for me. I'd like the proper
> python gurus to have a look over it though.
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e

