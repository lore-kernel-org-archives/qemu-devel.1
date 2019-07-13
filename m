Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD9CC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 21:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFBD2063F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFBD2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmPXg-0004qA-UX
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 17:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmPXT-0004QR-SW
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 17:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmPXP-0005S6-NL
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 17:26:39 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmPXJ-0005QD-64
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 17:26:31 -0400
Received: by mail-wr1-f44.google.com with SMTP id z1so13216428wru.13
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 14:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YbknY6pRFm76KunAO6TEGCvi/B4M/X8rocsqKp6/9IY=;
 b=if/dqCKSTEhpsJNk5bLg8Z9pLQmtcPTn6Sd19m8mAYcz9/k+AvVXrA+MTXDmbtFOnR
 Yqh4FcJ3OtWDOf5pOKVdSk7kxjUssGzkBLSJXPjaj3eN2leEeVCbxK82IEpdGFBnb/Yl
 bJhiRUnaTfaDk62vfFkF0bzfDZBmKy2Mif9NF7KAJea9nbWmNc7vU8eN72i7MNPelpsd
 ATITuj3+L/g2OPZqr0xb4S4J88nHVe9sdwmAlzVXjC7ltldvcaNNGCmlyN0NUXUnU0MX
 XkiDZMU0duKHJMyP8OQdEbjlTUvV0odA3wwEfuXR7PNzm0h3QVkF2ARJ16KJYU3XZm4u
 e77A==
X-Gm-Message-State: APjAAAWKsVButxHqV0XQ17zAzFamm5DGWihvl2nRqj5zCDmDvJAv06Jh
 pRFTXhdy5WIwxNMPjimIS7iSAA==
X-Google-Smtp-Source: APXvYqx7t2MsvBFYBP5pMzUzSp1v7BpC2T1JmRFX3QwjAKpg8WGH5ojeqCZQaslmQncOQRyjpb+9lA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr19394978wrw.185.1563053185082; 
 Sat, 13 Jul 2019 14:26:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c1b9:e491:30e8:c02?
 ([2001:b07:6468:f312:c1b9:e491:30e8:c02])
 by smtp.gmail.com with ESMTPSA id u2sm13544729wmc.3.2019.07.13.14.26.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 14:26:24 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
Date: Sat, 13 Jul 2019 23:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87d0ie58cj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/19 16:15, Markus Armbruster wrote:
>>                    In particular the tracing headers are using
>> $(build_root)/$(<D); for now my solution is to generate headers like
>> "trace/trace-audio.h" and have sixty one-line forwarding headers in the
>> source tree; for example "audio/trace.h" includes "trace/trace-audio.h".
>> I'm not sure if it's possible to instead add a one-line "generate
>> trace headers" directive to each subdirectory's meson.build file.
>> I suspect that it _is_ possible but you'd still have to change the
>> include directives to include the subdirectory name (and then I prefer
>> the forwarding headers).
> 
> I agree we want to keep '#include "trace.h"'.
> 
> I'm not sure I get the problem.
> 
> Having '#include "trace.h"' include trace.h from the including file's
> directory doesn't rely on include paths (GCC manual: "For the quote form
> of the include directive, the directory of the current file is searched
> first"), so setting up a suitable include path can't be the problem.

It is actually.  What you are describing is how the forwarding headers
work: they include trace.h from the including file's directory.  In the
current mechanism, instead, trace.h is found thanks to
"-I$(BUILD_DIR)/$(@D)".  That is, it comes from the build-directory
homologue of the including file's directory.

> Is convincing Meson to generate SUBDIR/FOO from SUBDIR/trace-events the
> problem?

That is currently a problem.  I haven't checked if it is fixable by
creating a meson.build file for each trace-events directory (which we
would have sooner or later, but not yet).  It probably would be fixable,
but the lack of a "-I$(BUILD_DIR)/$(@D)" equivalent in the include path
would still be an issue.

This is not a problem for the generated QAPI headers, because those are
included as "qapi/whatever.h".  Similarly, the trace.h forwarding
headers include the generated files as "trace/trace-whatever.h".

> Diff is a bit confusing here.  This is actually the deletion of
> trace-root.h rules, and the move of trace/generated-helpers-wrappers.h
> rules from trace/Makefile.objs.

Yep, in a final patch I would first introduce the forwarding headers in
the current Make environment.

> Diversion: I guess the timestamp thing is for avoiding recompilation
> when the generated .h does not change.  How is it supposed to work?
> After .h-timestamp is remade without changing its contents, make will
> then remake .h, but the recipe won't actually touch it.  How does make
> know?  If it doesn't, it'll consider the .o depending on the .h out of
> date.  Even if it does, it'll remake the .h on every make run until
> remaking it actually changes it.
> 
> The make trick I learned to accomplish this puts the "maybe update" in
> the .h-timestamp recipe, and keeps the .h recipe empty.  The rules for
> generating code from the QAPI schema work like that.  Look for
> qapi-gen-timestamp below.
> 
> Make is weird.  End of diversion.

> Looks like you're deleting some tracing code generation here, so you can
> do it in Meson, and move some other tracing code generation from trace/
> to here.  Why is not obvious to me; I'm not really familiar with tracing
> code generation.  Perhaps it'll become clearer further down.

It's because, with the disappearance of trace-obj-y, there's no
recursion into trace/ except for "obj-y += control-target.o" (which is
only processed in the *-softmmu and *-linux-user directories).

>>  QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h)
>>  $(qga-obj-y): $(QGALIB_GEN)
>>  
>> @@ -631,21 +517,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>>  endif
>> -vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
>> +vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
>>  	$(call LINK, $^)
> 
> First instance of adding $(COMMON_LDADDS) after libvhost-user.a.  Two
> more below.  What about the one in tests/Makefile.include?

I completely ignored tests/Makefile.include.

> Let's fix this in an independent patch.

Yup, side effects of going through the build system with a finer comb
than usual.

>> -stub-obj-y = stubs/ util/ crypto/
>> -util-obj-y = util/ qobject/ qapi/
> 
> More removal of stub-obj-y and util-obj-y.
> 
> Hmm, you add meson.build in qapi/ qobject/ stubs/ trace/ util/, but not
> in crypto/.  What am I missing?

For crypto/Makefile.objs I'm replacing libqemuutil.a with Boolean logic.
 Yet more material for a separate patch, as you suggest below.

>> -
>> +# chardev-obj-y is code used by both qemu system emulation and some tests
>>  chardev-obj-y = chardev/
> 
> Comment improvements could be in an independent patch.

Of course.

> We add sub-directories to the various FOO-obj-y, then add those of them
> with tracepoints to trace-events-subdirs.  Annoying.  Let's see whether
> you can do better with Meson.

Not yet.  But once I have all the meson.build files I could do

trace_events_files += [meson.current_source_dir()]

in all of them.  For now, adding 60 subdir files just for the sake of
that line is more confusing than helpful.

> So far, you deleted QAPI code generation, most of tracing code
> generation, and moved the rest of tracing code generation from
> trace/Makefile.objs here.
> 
> Can you explain why the move is necessary?

See above.

>> +slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
>> +                           link_args: config_host['SLIRP_LIBS'].split())
>> +
>> +target_dirs = config_host['TARGET_DIRS'].split()
> 
> config_host is from kconfig.load().  Looks like it's a dictionary
> mapping to strings.  Having to convert from string to the appropriate
> meson type (here: array) is annoying.  Any ideas on improving this?

Yes: getting rid of config-host.mak completely, and rewriting configure
in meson as well (configure would remain just for command line processing).

> Not necessarily right away, after the conversion to Meson is complete
> would do.
> 
>> +have_user = false
>> +have_system = false
>> +foreach target : target_dirs
>> +  have_user = have_user or target.endswith('-user')
>> +  have_system = have_system or target.endswith('-softmmu')
>> +endforeach
> 
> The loop is slightly disappointing.  I was hoping for something in a
> more functional style, similar to
> 
>    (some (lambda (tdir) (endswith tdir "-softmmu")) target_dirs)

You won't find much functional style I'm afraid, since Meson doesn't
have generators or something like any() or all().  +1 for Make here,
especially once you've gotten used to the $() syntax. :)

> * Related, but well outside the scope of a conversion to Meson: we
>   generate trace.* per directory.  Some of them are huge.  Some
>   directories have files with complex conditions.
> 
>   Consider hw/net.  17 files include hw/net/trace.h.  The resulting
>   trace.h exceeds 700KiB for me, more than twenty times as big as the
>   average .c including it.  Wasteful.  The resulting trace.o eats almost
>   80KiB text+data+bss.  Its users are all individually configured.
>   Configuring any of them pulls in tracing code for all of them.
>   Wasteful.

-ffunction-sections could help.

>> +# Build targets from sourcesets
>> +
>> +util_obj.add_all(stub_obj, trace_obj)
>> +util_obj = util_obj.apply(config_host, strict: false)
> 
> Peeking at Meson docs... aha, this filters util_obj for config_host.  I
> guess this takes care of the "when:" thingies in util/meson.build below.

Yes.

> No "when:" thingies in trace_obj, because we build it differently:
> first, we build array trace_events_subdirs (above), then we add their
> files to trace_obj (in trace/meson.build below).  To use "when:" there,
> we'd have to put the condition in the array, which is probably more
> complex and less readable.

Not entirely true.  There are no "when:" thingies in trace_obj because
everything ends up in a static library, so that the required object
files are chosen by the linker.

The trace_events_subdirs conditionals are a recent addition:

    commit 5b4a969a701fd298be7bb9a916f8918200cdd827
    Author: Laurent Vivier <lvivier@redhat.com>
    Date:   Mon Apr 1 16:12:18 2019 +0200

    trace: only include trace-event-subdirs when they are needed

    Some directories are built only for softmmu targets,
    and the related trace-event-subdirs must do the same

where the commit message really should have said "can" do the same.  It
saves a little bit of compilation time.

> * common-obj-y: the target-independent .o to link into
>   $(QEMU_PROG_BUILD), via $(all-obj-y)
> 
>   Deleted.  Doesn't feel right.  See below.

Gotcha.  It's harmless but a bit on the ugly side.  My preferred fix
here would be to add a FIXME to qapi/meson.build, and removing it after
common_obj becomes a thing.

> Idle thought, feel free to ignore.  "git-ls-files qapi/\*json" less
> qapi-schema.json yields the QAPI modules.  The ones ending with
> target.json are in qapi_target_modules, the others are in
> qapi_common_modules.  My point is: having to restate what git already
> knows annoys me a bit.
> 
> Of course, git-ls-files doesn't work when building from a tarball.
> Putting a generated list of files into the tarball could replace it
> there.

The philosophical question is whether Make should know about git or not.
 I'm more on the side of "or not", I like my build systems to be
self-contained and introspectable.

>> +
>> +qapi_files = custom_target('QAPI files',
>> +  output: qapi_all_outputs,
>> +  input: [ files('qapi-schema.json') ],
>> +  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
>> +  depend_files: [ qapi_inputs, qapi_gen_depends ])
> 
> This replaces rules deleted from the top-level Makefile.  Good.
> Note the conspicious loss of stamp file trickery :)
> 
>> +
>> +# qapi_util_outputs must be at the beginning of qapi_all_outputs.
>> +i = 0
>> +foreach output : qapi_util_outputs
>> +  util_obj.add(qapi_files[i])
>> +  i = i + 1
>> +endforeach
> 
> Hmm... "must be at the beginning" because the loop needs to iterate over
> the subset of qapi_files that corresponds to qapi_util_outputs.  Works
> (I guess) because the [index] method of the custom target object
> returned by custom_target() "corresponds to the index of the custom
> target's output argument", i.e. to qapi_all_outputs[index].  By putting
> qapi_util_outputs first in qapi_all_outputs, the qapi_files[i]
> correspond to the qapi_util_outputs[i].

Good material for a --verbose version of the comment. :)

> Let's compare with qapi/Makefile.objs before the patch.  Three sets of
> files:
> 
> * The (target-independent) .o to put put into libqemutil.a
> 
>   Before the patch: $(util-obj-y), which contains the .o for
> 
>   - all the hand-written .c
>   - the generated qapi-builtin-{types,visit}.c, qapi-emit-events.c
>   - the generated target-independent qapi-{types,visit,events}-*.c
> 
>   Afterwards: util_obj, which contains the file objects for
> 
>   - all the hand-written .c
>   - the generated qapi-builtin-{types,visit}.c, qapi-emit-events.c
>   - the generated target-independent
>     qapi-{types,visit,events,commands}-*.c
>   
>   You're adding the target-independent qapi-commands-*.c to
>   libqemutil.a.  Intentional?

Not really.  One possibility could be something like

  qapi_module_outputs = [
    'qapi-types-@0@.c'.format(module),
    'qapi-types-@0@.h'.format(module),
    'qapi-visit-@0@.c'.format(module),
    'qapi-visit-@0@.h'.format(module),
    'qapi-events-@0@.c'.format(module),
    'qapi-events-@0@.h'.format(module),
  ]
  qmp_module_outputs = [
    'qapi-commands-@0@.c'.format(module),
    'qapi-commands-@0@.h'.format(module),
  ]
  qapi_inputs += [ files(module + '.json') ]
  if qapi_common_modules.contains(module)
    qapi_util_outputs += qapi_module_outputs
    qapi_common_outputs += qmp_module_outputs
  else
    qapi_target_outputs += qapi_module_outputs + qmp_module_outputs
  endif

...
  qapi_all_outputs = qapi_util_outputs + qapi_common_outputs \
      + qapi_target_outputs
...
  # The order of these foreach statements must match the earlier
  # assignment to qapi_all_outputs, because...
  i = 0
  foreach output : qapi_util_outputs
    util_obj.add(qapi_files[i])
    i = i + 1
  endforeach
  foreach output : qapi_common_outputs
    common_obj.add(qapi_files[i])         # formerly common-obj-y
    i = i + 1
  endforeach
  foreach output : qapi_target_outputs
    target_obj.add(qapi_files[i])         # formerly obj-y
    i = i + 1
  endforeach

>> +util_obj.add(files('qnull.c', 'qnum.c', 'qstring.c', 'qdict.c', 'qlist.c', 'qbool.c',
>> +  'qlit.c', 'qjson.c', 'qobject.c', 'json-lexer.c', 'json-streamer.c', 'json-parser.c',
>> +  'block-qdict.c'))
> 
> Long lines.

Wouldn't be an issue to have one file per line.

> [Another forwarding header snipped...]
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 3d98ca2..c15daac 100755
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/env python
>> +#!/usr/bin/env python3
> 
> Can't wait.  But does it belong to this patch?

To trigger Meson's magic interpretation of the "#! /usr/bin/env python3"
shebang, to "call the script with the python interpreter that was used
to invoke Meson".  In turn, that python interpreter is the one that was
passed to --python.

That is of course why it is included in this patch, not why it belongs
to this patch.  Just like a bunch of things we're discovering along the
way we should do it now, and then it will just work when converting to
Meson.

>> -
>> -######################################################################
>> -# Backend code
>> -
>> -util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
>> -util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
>> -util-obj-y += control.o
>>  obj-y += control-target.o
>> -util-obj-y += qmp.o
> 
> The util-obj-y additions move to trace/meson.build.  The obj-y addition
> remains here for the same reason the one above does.
> 
> Should you keep the comment?

Not sure how accurate it is now, but I can.

> This replaces the pattern rules you deleted from the top-level Makefile.
> Good.
> 
> It also replaces the -root rules you deleted there; they're no longer a
> special case here.  Good.
> 
> The degradation from declarative to imperative is a bit sad.

Yes, Meson has this approach of "non-Turing complete imperative" that is
debatable.  It certainly favors a Python-like "there is only one way to
do it" style and discourages magic, but other times "a bit sad" is an
accurate description.

> I *guess* this is also where the problem you mentioned in the commit
> message really is: we generate the tracing files centrally here, and
> because of that the generated headers end up in one place rather than
> next to their trace-events.

Yes, though this may be the fixable part (the likely unfixable part is
-I$(BUILD_DIR)/$(@D), after which this other issue becomes moot).

> Okay, time to take a step back and look at the whole picture.
> 
> I still agree with your stated objectives for the conversion.
> 
> I went through this patch (and all of the v1 series before) with a fine
> comb, because I think replacing build tools is a momentous decision.
> 
> The Meson sources feel more organized than the Makefiles they replace.
> Related stuff tends to be together.
> 
> Also, intent often feels more obvious.  I think that's because Meson
> includes more useful batteries than Make, and their use tends to be more
> self-documenting than the "build up a bunch of variables containing
> <whatever>, to be used somewhere else <however>" we have with Make,
> where the reader is expected to know or find out <whatever> and
> <however>.  Comments explaining the purpose of important variables could
> help some, of course.
> 
> I'm a bit concerned about debugability.  Not exactly easy with complex
> Makefiles such as ours, but the "Meson generates Ninja generates
> Makefile" scares me.  Even with the last translation gone after the
> conversion completes, an uneasy feeling remains.  Could be just fear of
> the unknown.

Until now, debugging wasn't an issue.  All snags we encountered could
have happened anyway with Make, they obviously didn't happen with the
current Makefiles through happy accidents.

But, I'll be able to tell you more once I encounter paper cuts (and I
surely will).  We'll see how easy it is to debug them and fix them.

> As to next steps...
> 
> I think we should try to find out how to generate trace.h next to their
> trace-events.  Not because the forwarding headers are show-stoppers
> (they are not), but to get a feel for how constraining Meson is.  I
> understand why constraints can be beneficial, but too much results in a
> straightjacket.

I hope my remarks gives you a feeling for the constraints I am encountering.

In the words of Marc-André, the conversion does leave a bitter feeling
here and there.  With Make you have great power and great
responsibility, and it's easier to abuse both.  With Meson you have
little power and thus less responsibility; the better data structures
are a pleasure to work with, but sometimes you miss the power and just
want to scream.

The silver lining is that meson is very good at reporting errors early,
so until now I mostly screamed at it and not at ninja.  (The exception
is the issue I reported in the cover letter, but I promise it'll be fixed!).

> You mentioned during review of v1 that testing might pose some
> additional difficulties.  A PoC for selected tests would be nice.

Agreed.  Marc-André has converted qemu-ga already, and check-unit could
definitely be the next stage (well, first I need to rebase to a more
recent version).  Don't hold your breath, but I'm glad we're making
progress.  Thanks for helping with the experiment!

Paolo

